//
//  ExerciseDetailViewController.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/9/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit
import RxSwift

class ExcerciseDetailViewController: UIViewController, KeyboardAvoidable {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var outlineButton: UIButton!
    @IBOutlet weak var bottomTableConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultBottomViewConstraint: NSLayoutConstraint!
    private var heightAnswerView: CGFloat = 0
    @IBOutlet var viewModel: ExcerciceDetailViewModel!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.completedTest.drive(onNext: { [weak self] value in
            if value {
                self?.resultBottomViewConstraint.constant = 0
            } else {
                self?.resultBottomViewConstraint.constant = -50
            }
        }).disposed(by: disposeBag)
        viewModel.resultString.subscribe(onNext: { [weak self] string in
            self?.resultLabel.text =  string
        }).disposed(by: disposeBag)
        
        viewModel.showAnswerView.drive(onNext: { [weak self] value in
            if value {
                self?.heightAnswerView = 25
                self?.table.reloadData()
            } else {
                self?.heightAnswerView = 0
            }
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers(forConstraints: [bottomTableConstraint])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    func setup(excersice: ExerciseViewModel) {
        viewModel.setup(excercise: excersice)
    }
    
    @IBAction func done(_ sender: Any) {
        view.endEditing(true)
        viewModel.calculateScore()
    }
    
    @IBAction func outline(_ sender: Any) {
        viewModel.outline()
    }
    
}

extension ExcerciseDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let countPart = viewModel.exerciseViewModel?.parts.count, countPart > 0 else {
            return 1
        }
        return countPart
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberQuestions = viewModel.exerciseViewModel?.questions[section].count ?? 0
        guard let countPart = viewModel.exerciseViewModel?.parts.count, countPart > 1  else {
            return numberQuestions
        }
        return numberQuestions + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.indexRowDelta > 0, indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseHeaderCell.voca_identifier, for: indexPath) as? ExerciseHeaderCell {
                cell.setup(partTitle: viewModel.exerciseViewModel?.parts[indexPath.section] ?? "")
                return cell
            }
        } else {
            if let question =  viewModel.exerciseViewModel?.questions[indexPath.section][indexPath.row - viewModel.indexRowDelta], var questionItem = viewModel.questionItem(questionId: question.id) {
                if question.type == .abcd, let cell = tableView.dequeueReusableCell(withIdentifier: TypeABCDCell.voca_identifier, for: indexPath) as? TypeABCDCell {
                    cell.setup(question: questionItem)
                    cell.changeSelectedAnswersHandler = { [weak self]  (key,value) in
                        questionItem.selectedAnswers?[key] = value
                        questionItem.isCorrectAnsered = self?.viewModel.checkCorrect(questionItem: questionItem) ?? false
                        self?.viewModel.updateAnswersForQuestion(question: questionItem)
                    }
                    cell.keyAnswerView.backgroundColor = questionItem.isCorrectAnsered ? UIColor.green : UIColor.red
                    return cell
                } else if question.type == .text, let cell = tableView.dequeueReusableCell(withIdentifier: TypeTextCell.voca_identifier, for: indexPath) as? TypeTextCell {
                    cell.setup(question: questionItem)
                    cell.answerText.asObservable().subscribe(onNext: { [weak self]  string in
                        questionItem.textAnswer = string ?? ""
                        questionItem.isCorrectAnsered = self?.viewModel.checkCorrect(questionItem: questionItem) ?? false
                    }).disposed(by: disposeBag)
                    cell.answerKeyView.backgroundColor = questionItem.isCorrectAnsered ? UIColor.green : UIColor.red
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.indexRowDelta > 0, indexPath.row == 0 {
            return 45
        } else if let question =  viewModel.exerciseViewModel?.questions[indexPath.section][indexPath.row - viewModel.indexRowDelta], question.type == .text {
            return heightAnswerView == 0 ? 60 : 120
        }
        return 55 + heightAnswerView
    }
}
