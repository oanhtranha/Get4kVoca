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
    @IBOutlet weak var keyAnswerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var aButton: VocaRaidoButton!
    @IBOutlet private weak var bButton: VocaRaidoButton!
    @IBOutlet private weak var cButton: VocaRaidoButton!
    @IBOutlet private weak var dButton: VocaRaidoButton!
    @IBOutlet private weak var answerKeyLabel: UILabel!
    
    
    var changeSelectedAnswersHandler: ((String, Bool) -> Void)? = nil
    private var question: QuestionItem?
    
    func setup(question: QuestionItem) {
        titleLabel.text = String(format: "%@.", question.number)
        answerKeyLabel.text = question.answer
        self.question = question
        loadSelectedButtons(question: question)
    }
    
    private func loadSelectedButtons(question: QuestionItem) {
        let selectedAnswers = question.selectedAnswers
        aButton.isSelected = selectedAnswers?["a"] ?? false
        bButton.isSelected = selectedAnswers?["b"] ?? false
        cButton.isSelected = selectedAnswers?["c"] ?? false
        dButton.isSelected = selectedAnswers?["d"] ?? false
    }
    
    @IBAction private func checkRadio(_ sender: VocaRaidoButton) {
        sender.isSelected = !sender.isSelected
        switch sender {
        case aButton:
            changeSelectedAnswersHandler?("a", sender.isSelected)
        case bButton:
            changeSelectedAnswersHandler?("b", sender.isSelected)
        case cButton:
            changeSelectedAnswersHandler?("c", sender.isSelected)
        default:
            changeSelectedAnswersHandler?("d", sender.isSelected)
        }
    }
}
