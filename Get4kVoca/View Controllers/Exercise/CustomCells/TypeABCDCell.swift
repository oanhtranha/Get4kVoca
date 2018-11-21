//
//  TypeABCDCell.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/20/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit

class TypeABCDCell: UITableViewCell {
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var keyAnswerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var aButton: VocaRaidoButton!
    @IBOutlet weak var bButton: VocaRaidoButton!
    @IBOutlet weak var cButton: VocaRaidoButton!
    @IBOutlet weak var dButton: VocaRaidoButton!
    @IBOutlet weak var answerKeyLabel: UILabel!
    private var question: Question?
    var selectedAnswers: Dictionary<String,Bool> = ["a" : false, "b" : false, "c" : false, "d" : false]
    func setup(question: Question?) {
        if let ques = question {
            titleLabel.text = ques.number
            answerKeyLabel.text = ques.answer
            self.question = ques
        }
    }
    
    @IBAction func checkRadio(_ sender: VocaRaidoButton) {
        switch sender {
        case aButton:
            aButton.isSelected = !aButton.isSelected
            selectedAnswers["a"] = aButton.isSelected
        case bButton:
            bButton.isSelected = !bButton.isSelected
            selectedAnswers["b"] = bButton.isSelected
        case cButton:
            cButton.isSelected = !cButton.isSelected
            selectedAnswers["c"] = cButton.isSelected
        default:
            dButton.isSelected = !dButton.isSelected
            selectedAnswers["d"] = dButton.isSelected
        }
    }
    
    func finalAnswer() -> String {
        var finalAnswer: String = ""
        for answer in selectedAnswers {
            finalAnswer.append(answer.value ? answer.key : "")
        }
        return finalAnswer
    }
    
    func isCorrectAnswered() -> Bool {
        if let question = question {
           return finalAnswer().lowercased() == question.answer?.replacingOccurrences(of: ", ", with: "").lowercased()
        }
        return false
    }
    
}
