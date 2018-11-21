//
//  ExerciseDetailViewController.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/9/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit

class ExcerciseDetailViewController: UIViewController {
    
    @IBOutlet var viewModel: ExcerciceDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setup(excersice: ExerciseViewModel) {
        viewModel.setup(excercise: excersice)
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
        guard let countPart = viewModel.exerciseViewModel?.parts.count, countPart == 0 else {
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseHeaderCell.voca_identifier, for: indexPath) as? ExerciseHeaderCell {
                    cell.setup(partTitle: viewModel.exerciseViewModel?.parts[indexPath.section] ?? "")
                    return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: TypeABCDCell.voca_identifier, for: indexPath) as? TypeABCDCell {
                    cell.setup(question: viewModel.exerciseViewModel?.questions[indexPath.section][indexPath.row - 1])
                    return cell
                }
            }
            return UITableViewCell()
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: TypeABCDCell.voca_identifier, for: indexPath) as? TypeABCDCell {
            cell.setup(question: viewModel.exerciseViewModel?.questions[indexPath.section][indexPath.row])
            return cell
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
        return 135
    }
}
