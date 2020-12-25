//
//  ExpenseData+CoreDataProperties.swift
//  GrubberDemo
//
//  Created by Puneet Shah on 25/12/20.
//  Copyright © 2020 Puneet Shah. All rights reserved.
//
//

import Foundation
import CoreData


extension ExpenseData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseData> {
        return NSFetchRequest<ExpenseData>(entityName: "ExpenseData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var title: String?
    @NSManaged public var amount: Int64
    @NSManaged public var category: String?

}
