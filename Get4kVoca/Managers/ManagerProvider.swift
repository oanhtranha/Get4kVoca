//
//  ManagerProvider.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/6/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import Foundation

class ManagerProvider {
    
    static let sharedInstance: ManagerProvider = {
        return ManagerProvider(dataManager: DataManager())
    }()
    
    init(dataManager: DataManager) {
        self.dataManager =  dataManager
    }
    
    let dataManager: DataManager
    
    private (set) lazy var questionManager = QuestionManager(dataManager: dataManager)
}
