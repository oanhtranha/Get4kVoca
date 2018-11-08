//
//  UnitTableViewCell.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/8/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit

class UnitTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
  
    func setup(with title: String) {
        titleLabel.text = title
    }

}
