//
//  TypeABCDCell.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/20/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit

class TypeABCDCell: UITableViewCell {
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var keyAnswerView: UIView!
    @IBOutlet weak var aButton: VocaRaidoButton!
    @IBOutlet weak var bButton: VocaRaidoButton!
    @IBOutlet weak var cButton: VocaRaidoButton!
    @IBOutlet weak var dButton: VocaRaidoButton!
    
    @IBAction func checkRadio(_ sender: VocaRaidoButton) {
        switch sender {
        case aButton:
            aButton.isSelected = !aButton.isSelected
        case bButton:
            bButton.isSelected = !bButton.isSelected
        case cButton:
            cButton.isSelected = !cButton.isSelected
        default:
            dButton.isSelected = !dButton.isSelected
        }
    }
    
    
}
