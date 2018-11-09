//
//  HomeViewModel.swift
//  Get4kVoca
//
//  Created by Oanh tran on 10/2/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import Foundation
import RxCocoa
import CoreData
import CocoaLumberjackSwift


class HomeViewModel: BaseViewModel {
    
    private let questionManager: QuestionManager
    private let dataManager: DataManager
    
    override init(managerProvider: ManagerProvider = ManagerProvider.sharedInstance) {
        questionManager = managerProvider.questionManager
        dataManager = managerProvider.dataManager
        super.init(managerProvider: managerProvider)
    }
    
    func initData() {
        questionManager.importQuestionToDataBase()
    }
}
