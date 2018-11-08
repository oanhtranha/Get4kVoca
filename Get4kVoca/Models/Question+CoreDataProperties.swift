//
//  Question+CoreDataProperties.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/8/18.
//  Copyright © 2018 activecog. All rights reserved.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var answer: String?
    @NSManaged public var exercise: String?
    @NSManaged public var number: String?
    @NSManaged public var part: String?
    @NSManaged public var typeAnswer: String?
    @NSManaged public var unit: Int16

}
