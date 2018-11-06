//
//  HomeViewController.swift
//  Get4kVoca
//
//  Created by Oanh tran on 10/2/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var viewModel: HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.initData()
    }
}
