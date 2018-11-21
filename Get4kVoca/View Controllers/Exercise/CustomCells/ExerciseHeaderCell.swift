//
//  ExerciseHeaderCell.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/21/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit

class ExerciseHeaderCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    func setup(partTitle: String) {
        titleLabel.text = partTitle
    }
}
