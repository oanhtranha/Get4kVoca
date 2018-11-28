//
//  ExerciseDetailViewController.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/9/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit
import RxSwift

class ExcerciseDetailViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var outlineButton: UIButton!
    @IBOutlet weak var bottomTableConstraint: NSLayoutConstraint!
    private var heightAnswerView: CGFloat = 0
    @IBOutlet var viewModel: ExcerciceDetailViewModel!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.completedTest.drive(onNext: { [weak self] value in
            if value {
                self?.bottomTableConstraint.constant = 50
            } else {
                self?.bottomTableConstraint.constant = 0
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
    
    func setup(excersice: ExerciseViewModel) {
        viewModel.setup(excercise: excersice)
    }
    
    @IBAction func done(_ sender: Any) {
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
        if let countPart = viewModel.exerciseViewModel?.parts.count, countPart > 0 {
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseHeaderCell.voca_identifier, for: indexPath) as? ExerciseHeaderCell {
                    cell.setup(partTitle: viewModel.exerciseViewModel?.parts[indexPath.section] ?? "")
                    return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: TypeABCDCell.voca_identifier, for: indexPath) as? TypeABCDCell, var question =  viewModel.exerciseViewModel?.questions[indexPath.section][indexPath.row - 1], let questionItem = viewModel.questionItem(questionId: question.id){
                    cell.setup(question: questionItem)
                    print("Row: \(indexPath.section) - \(indexPath.row) : \(questionItem.id) \(questionItem.selectedAnswers)")
                    cell.changeSelectedAnswersHandler = { [weak self]  (key,value) in
                        question.selectedAnswers?[key] = value
                        question.isCorrectAnsered = self?.viewModel.checkCorrect(questionItem: question) ?? false
                        self?.viewModel.updateAnswersForQuestion(question: question)
                    }
                    cell.keyAnswerView.backgroundColor = question.isCorrectAnsered ? UIColor.green : UIColor.red
                    return cell
                }
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: TypeABCDCell.voca_identifier, for: indexPath) as? TypeABCDCell, var question = viewModel.exerciseViewModel?.questions[indexPath.section][indexPath.row], let questionItem = viewModel.questionItem(questionId: question.id){
                cell.setup(question: questionItem)
                cell.changeSelectedAnswersHandler = { [weak self]  (key,value) in
                    question.selectedAnswers?[key] = value
                    question.isCorrectAnsered = self?.viewModel.checkCorrect(questionItem: question) ?? false
                    self?.viewModel.updateAnswersForQuestion(question: question)
                }
                return cell
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
        if let countPart = viewModel.exerciseViewModel?.parts.count, countPart > 1, indexPath.row == 0 {
            return 45
        }
        return 55 + heightAnswerView
    }
}
