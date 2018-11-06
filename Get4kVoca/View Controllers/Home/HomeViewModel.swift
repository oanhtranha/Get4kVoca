//
//  HomeViewModel.swift
//  Get4kVoca
//
//  Created by Oanh tran on 10/2/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import Foundation
import CoreData

class HomeViewModel: BaseViewModel {
    
    private let questionManager: QuestionManager
    private let dataManager: DataManager
    
    private let unitsFetchedResultsController: NSFetchedResultsController<Question>
    
    override init(managerProvider: ManagerProvider = ManagerProvider.sharedInstance) {
        questionManager = managerProvider.questionManager
        dataManager = managerProvider.dataManager
        
        let unitsFetchRequest = NSFetchRequest<Question>(entityName: Question.voca_entityName)
        unitsFetchRequest.sortDescriptors = [NSSortDescriptor(key: "unit", ascending: false)]
        unitsFetchRequest.returnsObjectsAsFaults = false
        
        unitsFetchedResultsController = NSFetchedResultsController(fetchRequest: unitsFetchRequest, managedObjectContext: dataManager.dataStack.mainContext, sectionNameKeyPath: "unit", cacheName: nil)
        
        super.init(managerProvider: managerProvider)
    }
    
    func initData() {
        questionManager.importQuestionToDataBase()
    }
}
