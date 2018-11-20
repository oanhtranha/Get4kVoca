//
//  ExcerciseViewController.swift
//  Get4kVoca
//
//  Created by Oanh tran on 10/2/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit
import RxSwift

class ExcerciseViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var viewModel: ExcerciseViewModel!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadTableView.drive(onNext: { [weak self] _ in
            self?.viewModel.initExpandList()
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ExcerciseDetailViewController.voca_identifier, let controller = segue.destination as? ExcerciseDetailViewController, let selectedRowIndexPath = tableView.indexPathForSelectedRow, let selectedExercise = viewModel.selectedExercise(indexPath: selectedRowIndexPath) {
            controller.setup(excersice: selectedExercise)
        }
    }
}

extension ExcerciseViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.unitDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // First will always be header
        return  viewModel.expandList[section] ?  1 + viewModel.unitDataSource[section].exercises.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "UnitTableViewCell", for: indexPath) as? UnitTableViewCell {
                cell.setup(with: viewModel.unitDataSource[indexPath.section].unit)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as? ExerciseTableViewCell {
                cell.setup(with: viewModel.unitDataSource[indexPath.section].exercises[indexPath.row-1])
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Expand/hide the section if tapped its header
        if indexPath.row == 0 {
            viewModel.expandList[indexPath.section] = !viewModel.expandList[indexPath.section]
            tableView.reloadSections([indexPath.section], with: .automatic)
        } else {
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
