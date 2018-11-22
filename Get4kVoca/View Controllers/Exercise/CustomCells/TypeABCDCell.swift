//
//  TypeABCDCell.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/20/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit

class TypeABCDCell: UITableViewCell {
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var keyAnswerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var aButton: VocaRaidoButton!
    @IBOutlet private weak var bButton: VocaRaidoButton!
    @IBOutlet private weak var cButton: VocaRaidoButton!
    @IBOutlet private weak var dButton: VocaRaidoButton!
    @IBOutlet private weak var answerKeyLabel: UILabel!
    
    var changeSelectedAnswersHandler: ((Dictionary<String,Bool>) -> Void)? = nil
    private var question: QuestionItem?
    private var selectedAnswers: Dictionary<String,Bool> = ["a" : false, "b" : false, "c" : false, "d" : false]
    func setup(question: QuestionItem) {
        titleLabel.text = String(format: "%@.", question.number)
        answerKeyLabel.text = question.answer
        self.question = question
    }
    
    @IBAction private func checkAButton(_ sender: Any) {
        aButton.isSelected = !aButton.isSelected
        selectedAnswers["a"] = aButton.isSelected
    }
    
    @IBAction private func checkBButton(_ sender: Any) {
        bButton.isSelected = !bButton.isSelected
        selectedAnswers["b"] = bButton.isSelected
    }
    
    @IBAction private func checkCButton(_ sender: Any) {
        cButton.isSelected = !cButton.isSelected
        selectedAnswers["c"] = cButton.isSelected
    }
    
    @IBAction private func checkDButton(_ sender: Any) {
        dButton.isSelected = !dButton.isSelected
        selectedAnswers["d"] = dButton.isSelected
    }
    
    
//    @IBAction private func checkRadio(_ sender: VocaRaidoButton) {
//        switch sender {
//        case aButton:
//            aButton.isSelected = !aButton.isSelected
//            selectedAnswers["a"] = aButton.isSelected
//        case bButton:
//            bButton.isSelected = !bButton.isSelected
//            selectedAnswers["b"] = bButton.isSelected
//        case cButton:
//            cButton.isSelected = !cButton.isSelected
//            selectedAnswers["c"] = cButton.isSelected
//        default:
//            dButton.isSelected = !dButton.isSelected
//            selectedAnswers["d"] = dButton.isSelected
//        }
//        changeSelectedAnswersHandler?(selectedAnswers)
//    }
}
