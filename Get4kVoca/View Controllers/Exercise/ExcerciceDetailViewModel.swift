//
//  ExerciceDetailViewModel.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/9/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class ExcerciceDetailViewModel: BaseViewModel {
    
    var exerciseViewModel: ExerciseViewModel?
    var completedTest : Driver<Bool> { return completedTestSubject.asDriver(onErrorJustReturn: false) }
    var resultString: Observable<String> { return _resultString }
    var showAnswerView: Driver<Bool> { return  showAnswerViewSubject.asDriver(onErrorJustReturn: false) }
    var indexRowDelta: Int = 0
    
    private var showAnswerViewSubject = BehaviorSubject(value: false )
    private var completedTestSubject = BehaviorSubject(value: false )
    private var _resultString = PublishSubject<String>()
    private var resultList : [QuestionItem] = []
    override init(managerProvider: ManagerProvider) {
        super.init(managerProvider: managerProvider)
    }
    
    func setup(excercise: ExerciseViewModel) {
        exerciseViewModel = excercise
        if let countPart = exerciseViewModel?.parts.count, countPart > 0 {
            indexRowDelta = 1
        }
        _resultString.onNext("....")
        if let questionOfExercise = exerciseViewModel?.questions {
            for questions in questionOfExercise {
                resultList.append(contentsOf: questions)
            }
        }
    }
    
    func outline() {
        showAnswerViewSubject.onNext(true)
    }
    
    func calculateScore() {
        _resultString.onNext("....")
        let correctedQuestions = resultList.filter { $0.isCorrectAnsered }
        let totalQuestions = resultList.count
        if correctedQuestions.count == totalQuestions {
            _resultString.onNext("\(totalQuestions)/\(totalQuestions) - Well Done!")
        } else {
            _resultString.onNext("Score is: \(correctedQuestions.count)/\(totalQuestions)")
        }
        completedTestSubject.onNext(true)
    }
    
    func updateAnswersForQuestion(question: QuestionItem) {
        if let indexQues =  resultList.index(where: { $0.id == question.id }) {
            resultList.remove(at: indexQues)
            resultList.insert(question, at: indexQues)
        }
    }
    
    func questionItem(questionId: String) -> QuestionItem? {
         return resultList.filter({ $0.id == questionId }).first
    }
    
    func checkCorrect(questionItem: QuestionItem) -> Bool {
        var finalAnswer: String = ""
        if questionItem.type == .abcd, let selectedAnswers = questionItem.selectedAnswers {
            for answer in selectedAnswers {
                finalAnswer.append(answer.value ? answer.key : "")
            }
        } else {
            finalAnswer = questionItem.textAnswer
        }
        
        let correctAnswer = questionItem.answer.replacingOccurrences(of: ", ", with: "").replacingOccurrences(of: " ", with: "")
        return finalAnswer.lowercased() == correctAnswer.lowercased()
    }
}
