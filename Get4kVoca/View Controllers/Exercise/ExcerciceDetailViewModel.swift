//
//  ExerciceDetailViewModel.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/9/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import Foundation

class ExcerciceDetailViewModel: BaseViewModel {
    
    var exerciseViewModel: ExerciseViewModel?
    
    
    override init(managerProvider: ManagerProvider) {
        super.init(managerProvider: managerProvider)
    }
    
    func setup(excercise: ExerciseViewModel) {
        exerciseViewModel = excercise
    }
}
