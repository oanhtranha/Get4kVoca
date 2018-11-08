//
//  ExcerciseViewModel.swift
//  Get4kVoca
//
//  Created by Oanh tran on 10/2/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import CoreData
import CocoaLumberjackSwift

class ExcerciseViewModel: BaseViewModel {
    
    
    private let questionManager: QuestionManager
    private let dataManager: DataManager
    private let unitsFetchedResultsController: NSFetchedResultsController<Question>
    
    var reloadTableView: Driver<Void> { return reloadTableViewSubject.asDriver(onErrorJustReturn: ()) }
    private var reloadTableViewSubject = PublishSubject<Void>()
    
    var unitDataSource: [UnitSectionViewModel] = []
    var expandList : [Bool] = []
    
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
        unitDataSource = unitsViewModels()
        reloadTableViewSubject.onNext(())
    }
    
    func unitsViewModels() -> [UnitSectionViewModel] {
        guard let fetchedUnits = unitsFetchedResultsController.sections else { return [] }
        
        return fetchedUnits.compactMap { section in
            guard let fetchedUnit = section.objects as? [Question] else { return nil }
            return UnitSectionViewModel(unit: section.name, questions: fetchedUnit)
        }
    }
    
    
    func initExpandList() {
        guard unitDataSource.count > 1 else {
            return
        }
        expandList = [Bool](repeating: false, count: unitDataSource.count)
    }
    
}


extension ExcerciseViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateUnitViewModels()
    }
}
