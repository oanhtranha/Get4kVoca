//
//  ExerciseSectionViewModel.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/8/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import RxSwift
import CoreData
import CocoaLumberjackSwift

class UnitSectionViewModel {
   
    private (set) var exercises: [String] = []
    private var exerciceViewModels: [ExerciseViewModel] = []
    let unit: String
    
    
    init(unit: String, questions: [Question]) {
        self.unit = unit
        groupQuestionsByExercise(questions: questions)
    }
    
    private func groupQuestionsByExercise(questions: [Question]) {
        let exercisesDictionary = Dictionary(grouping: questions, by: { $0.exercise }).sorted(by: { $0.0 ?? "" < $1.0 ?? "" })
        self.exercises = exercisesDictionary.compactMap { [weak self] (exercise, questionsOfExercise) in
            self?.exerciceViewModels.append(.init(exercise: exercise, questions: questionsOfExercise))
            return exercise
        }
    }
    
    func loadExercise(by exerciseName: String) -> ExerciseViewModel? {
        let exercises = exerciceViewModels.filter { $0.exercise == exerciseName }
        return exercises.first
    }
}

class ExerciseViewModel {
    let exercise: String
    var parts: [String] = []
    var questions: [[QuestionItem]] = []
    
    init(exercise: String?, questions: [Question]) {
        self.exercise = exercise ?? ""
        groupQuestionsByPart(questionsOfExercise: questions)
    }
    
    private func groupQuestionsByPart(questionsOfExercise: [Question]) {
        guard let part = questionsOfExercise.first?.part, part.contains("Part") else {
            let questionItems = convertQuestionItems(questions: questionsOfExercise)
            self.questions = [questionItems]
            return
        }
        let partsGrouped = Dictionary(grouping: questionsOfExercise, by: { $0.part })
        let partsDictionary = partsGrouped.sorted{ $0.key ?? "" < $1.key ?? "" }
        parts = partsDictionary.compactMap { [weak self] (part, questionsOfPart) in
            let questionItems = convertQuestionItems(questions: questionsOfPart)
            self?.questions.append(questionItems.sorted(by: { Int($0.number) ?? 0 < Int($1.number) ?? 0}))
            return part
        }
    }
    
    private func convertQuestionItems(questions: [Question]) -> [QuestionItem] {
        return questions.compactMap { question in
            let id = String(format: "%d%@%@%@", question.unit, question.exercise ?? "", question.part ?? "", question.number ?? "").replacingOccurrences(of: " ", with: "")
            return QuestionItem(id: id, number: question.number ?? "", answer: question.answer ?? "")
        }
    }
    
}

struct QuestionItem {
    let id: String
    let number: String
    let answer: String
    var selectedAnswers: Dictionary<String,Bool>?
    var isCorrectAnsered: Bool
    
    init(id: String, number: String, answer: String, selectedAnswers: Dictionary<String,Bool> = ["a" : false, "b" : false, "c" : false, "d" : false], isCorrectAnsered: Bool = false) {
        self.id = id
        self.number = number
        self.answer = answer
        self.selectedAnswers =  selectedAnswers
        self.isCorrectAnsered = isCorrectAnsered
    }
}
