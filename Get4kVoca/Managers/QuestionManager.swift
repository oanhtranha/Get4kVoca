//
//  QuestionManager.swift
//  Get4kVoca
//
//  Created by Oanh tran on 10/2/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import Foundation
import SwiftyJSON
import CocoaLumberjackSwift

enum TypeAnswer {
    case abcd
    case text
}

struct QuestionFF {
    var number: String
    var answer: String
    var part: String?
    var exercise: String
    var unit: Int16
    var typeAnswer: String
}

class QuestionManager {
    
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func saveAllQuestionToDB(allQuestionFF: [QuestionFF]) {
        allQuestionFF.compactMap { questionFF in
            insertNewQuestion(questionFF: questionFF)
            return
        }
    }
    
    func checkQuestionsImported() -> Bool {
        guard let _ = self.firstQuestion() else {
            return false
        }
        return true
    }
    
    private func firstQuestion() -> Question? {
        var result: Question? = nil
        if let question = dataManager.fetchFirst(Question.self) {
            result = question
        } else {
            DDLogInfo("Can't retrieve cached user profile")
        }
        
        return result
    }
    
    private func insertNewQuestion(questionFF: QuestionFF) {
        let question: Question = self.dataManager.insertNew(Question.self)
        question.update(with: questionFF)
        dataManager.saveContext()
    }
    
}

extension QuestionManager {
    
    func importQuestionToDataBase() {
        let dataManager = DataManager()
        let questionManager = QuestionManager(dataManager: dataManager)
        guard questionManager.checkQuestionsImported() else {
            return
        }
        let allQuestions = loadQuestionsFromFile()
        questionManager.saveAllQuestionToDB(allQuestionFF: allQuestions)
    }
    
    
    func loadQuestionsFromFile() -> [QuestionFF] {
        let allDataContents = readDataFromLocalFile()
        var questionList : [QuestionFF] = []
        var unit : Int?
        var exercise : String?
        var part : String?
        for line in allDataContents {
            if line.contains("Unit") {
                let unitString: String = line.replacingOccurrences(of: "Unit", with: "")
                unit = Int(unitString.replacingOccurrences(of: " ", with: ""))
                exercise = nil
            }
            if line.contains("Exercise") || line.contains("Reading Comprehension") {
                exercise = line
                part = nil
            }
            
            if line.contains("Part") {
                part = line
            }
            
            if line.contains(".") {
                let splitLine : [String] = line.components(separatedBy: ".")
                let answerType: String = getTypeOfAnswer(answer: splitLine[1])
                
                let question = QuestionFF(number: splitLine[0], answer: splitLine[1], part: part ?? "", exercise: exercise ?? "", unit: Int16(unit ?? 0), typeAnswer: answerType)
                questionList.append(question)
            }
        }
        return questionList
    }
    
    private func readDataFromLocalFile() -> [String] {
        
        var text: [String] = []
        let fileName = "KeyAnswer"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        //
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        /*** Read from project txt file ***/
        
        // File location
        let fileURLProject = Bundle.main.path(forResource: "ProjectTextFile", ofType: "txt")
        // Read from the file
        var readStringProject = ""
        do {
            readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        
        do {
            text = readStringProject.components(separatedBy: "\n")
        } catch {
            Swift.print("Fatal Error: Couldn't read the contents!")
        }
        return text
    }
    
    private func getTypeOfAnswer(answer: String) -> String {
        let answerKey =  answer.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: " ", with: "")
        var maxKeyAnswer = 4
        if answerKey.count >= maxKeyAnswer {
            return "text"
        } else {
            answerKey.compactMap { char in
                if ["a", "b", "c", "d"].contains(char) {
                    maxKeyAnswer = maxKeyAnswer - 1
                }
            }
            if maxKeyAnswer == 4 - answerKey.count {
                return "abcd"
            }
        }
        return "text"
    }
}

extension Question {
    
    func update(with questionFF: QuestionFF) {
        unit = questionFF.unit
        part = questionFF.part
        exercise = questionFF.exercise
        answer = questionFF.answer
        number = questionFF.number
        typeAnswer = questionFF.typeAnswer
    }
}


