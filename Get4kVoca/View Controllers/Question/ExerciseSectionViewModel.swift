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
    private var exerciceViewModel: [ExerciseViewModel] = []
    let unit: String
    
    
    init(unit: String, questions: [Question]) {
        self.unit = unit
        groupQuestionsByExercise(questions: questions)
    }
    
    private func groupQuestionsByExercise(questions: [Question]) {
        let exercisesDictionary = Dictionary(grouping: questions, by: { $0.exercise }).sorted(by: { $0.0 ?? "" < $1.0 ?? "" })
        self.exercises = exercisesDictionary.compactMap { [weak self] (exercise, questionsOfExercise) in
            self?.exerciceViewModel.append(.init(exercise: exercise, questions: questionsOfExercise))
            return exercise
        }
    }
}

class ExerciseViewModel {
    let exercise: String
    var parts: [String] = []
    var questions: [[Question]] = []
    
    init(exercise: String?, questions: [Question]) {
        self.exercise = exercise ?? ""
        groupQuestionsByPart(questions: questions)
    }
    
    private func groupQuestionsByPart(questions: [Question]) {
        guard questions.first?.part != "" else {
            self.questions = [questions]
            return
        }
        let partsDictionary = Dictionary(grouping: questions, by: { $0.part }).sorted(by: { Int($0.1.first?.number ?? "") ?? 0 < Int($1.1.first?.number ?? "") ?? 0  })
        parts = partsDictionary.compactMap { [weak self] (part, questionsOfPart) in
            self?.questions.append(questionsOfPart)
            return part
        }
    }
    
}
