//  CoreDataManager.swift
//  GrubberDemo
//
//  Created by Puneet Shah on 25/12/20.
//  Copyright © 2020 Puneet Shah. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    //Saving resoponse data in core data
    static func saveDataInDB(date:Date, title:String, category:String, amount:Int64){
        
        DispatchQueue.main.async {
            
            let managedObjectContext:NSManagedObjectContext = AppSharedData.database_Context
            let expenseData = NSEntityDescription.insertNewObject(forEntityName: "ExpenseData",
                                                                  into: managedObjectContext) as! ExpenseData
            
            expenseData.date = date
            expenseData.title = title
            expenseData.category = category
            expenseData.amount = amount
            
            do {
                try managedObjectContext.save()
                print("Saving successfully")
            } catch {
                print("Saving failed")
            }
            
        }
        
    }
    
    
    
    //Fetch all Expense data
    static func fetchExpenseData() -> [ExpenseData]{
        
        let context = AppSharedData.database_Context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ExpenseData")
        
        var arrayOfExpenseData = [ExpenseData]()
        do {
            let results = try context.fetch(fetchRequest)
            let  dataResult = results as! [ExpenseData]
            
            for result in dataResult {
                print(result)
                arrayOfExpenseData.append(result)
            }
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
        return arrayOfExpenseData
        
    }
    
}

