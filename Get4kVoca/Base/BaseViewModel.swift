//
//  BaseViewModel.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/6/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import Foundation

class BaseViewModel: NSObject {
    override convenience init() {
        self.init(managerProvider: .sharedInstance)
    }
    
    init(managerProvider: ManagerProvider = .sharedInstance) {
        super.init()
    }
}
