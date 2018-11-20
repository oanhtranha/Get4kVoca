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
        return viewModel.exerciseViewModel?.parts.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // First will always be header
        return viewModel.exerciseViewModel?.questions[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TypeABCDCell.voca_identifier, for: indexPath) as? TypeABCDCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.exerciseViewModel?.parts[section] ?? ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
}
