//
//  TypeTextCell.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/20/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TypeTextCell: UITableViewCell {

    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var questionView: UIView!
    @IBOutlet weak var answerKeyView: UIView!
    @IBOutlet private weak var nunberLabel: UILabel!
    @IBOutlet private weak var answerTextView: UITextView!
    @IBOutlet private weak var answerKeyLabel: UILabel!
    private let disposeBag = DisposeBag()
    private var question: QuestionItem?
    var answerText = Variable<String?>(nil)
    
    func setup(question: QuestionItem) {
        nunberLabel.text = String(format: "%@.", question.number)
        answerKeyLabel.text = question.answer
        self.question = question
        self.answerTextView.text = question.answer
        answerText
            .asObservable()
            .bind(to: answerTextView.rx.text)
            .disposed(by: disposeBag)
    }
}
