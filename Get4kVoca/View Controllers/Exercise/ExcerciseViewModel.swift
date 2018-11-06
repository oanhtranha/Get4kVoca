//
//  ExcerciseViewModel.swift
//  Get4kVoca
//
//  Created by Oanh tran on 10/2/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import Foundation

class ExcerciseViewModel: BaseViewModel {
    
    
    private let questionManager : QuestionManager
    
    override init(managerProvider: ManagerProvider = ManagerProvider.sharedInstance) {
        questionManager = managerProvider.questionManager
        super.init(managerProvider: managerProvider)
    }
    
    
}
