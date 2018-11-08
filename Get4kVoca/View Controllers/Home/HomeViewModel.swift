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
    
    private let unitsFetchedResultsController: NSFetchedResultsController<Question>
    
    override init(managerProvider: ManagerProvider = ManagerProvider.sharedInstance) {
        questionManager = managerProvider.questionManager
        dataManager = managerProvider.dataManager
        
        let unitsFetchRequest = NSFetchRequest<Question>(entityName: Question.voca_entityName)
        unitsFetchRequest.sortDescriptors = [NSSortDescriptor(key: "unit", ascending: false)]
        unitsFetchRequest.returnsObjectsAsFaults = false
        
        unitsFetchedResultsController = NSFetchedResultsController(fetchRequest: unitsFetchRequest, managedObjectContext: dataManager.dataStack.mainContext, sectionNameKeyPath: "unit", cacheName: nil)
        
        super.init(managerProvider: managerProvider)
        initialize()
    }
    
    func initialize() {
        unitsFetchedResultsController.delegate = self
        fetchAllUnits()
    }
    
    private func fetchAllUnits() {
        do {
            try unitsFetchedResultsController.performFetch()
            updateUnitViewModels()
        } catch {
            DDLogError("Failed to fetch all Units - \(error)")
        }
    }
    
    fileprivate func updateUnitViewModels() {
        let units = unitsViewModels()
    }
    
    func unitsViewModels() -> [UnitSectionViewModel] {
        guard let fetchedUnits = unitsFetchedResultsController.sections else { return [] }
        
        return fetchedUnits.compactMap { section in
            guard let fetchedUnit = section.objects as? [Question] else { return nil }
            return UnitSectionViewModel(unit: section.name, questions: fetchedUnit)
        }
    }
  
    
    func initData() {
        questionManager.importQuestionToDataBase()
    }
}

extension HomeViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateUnitViewModels()
    }
}
