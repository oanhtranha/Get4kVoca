//
//  ExerciseDetailViewController.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/9/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit

class ExcerciseDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didselected(_ sender: VocaRaidoButton) {
        sender.isSelected = !sender.isSelected
    }
    
}
