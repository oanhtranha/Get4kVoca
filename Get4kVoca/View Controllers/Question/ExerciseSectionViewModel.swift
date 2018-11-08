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

class UnitSectionViewModel: BaseViewModel {
   
    private let questionManager: QuestionManager
    private (set) var exercises: [String] = []
    let unit: String
    var expanding: Bool = false
    
    init(unit: String, questions: [Question], managerProvider: ManagerProvider = ManagerProvider.sharedInstance) {
        self.unit = unit
        self.questionManager = managerProvider.questionManager
        super.init(managerProvider: managerProvider)
        groupQuestionsByExercise(questions: questions)
        
    }
    
    private func groupQuestionsByExercise(questions: [Question]) {
        let exercisesDictionary = Dictionary(grouping: questions, by: { $0.exercise })
        self.exercises = exercisesDictionary.compactMap { (key, _) in
            return key
        }

//        if let _ = questions[0].part {
//            let partDictionary = Dictionary(grouping: questions, by: { $0.part }).sorted(by: { ($0.1.first?.number ?? "") < ($1.1.first?.number ?? "") })
//            for (key, value) in partDictionary {
//                if let partName =  key {
//                    self.questions.append(partName.count > 1 ? partName : "Part \(partName)")
//                    self.questions.append(contentsOf: value)
//                    self.parts.append(partName)
//                }
//            }
//        } else {
//            self.questions = questions.sorted(by: { $0.number ?? "" < $1.number ?? "" })
//        }
    }
}
