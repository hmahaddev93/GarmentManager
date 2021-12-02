//
//  DataManager.swift
//  TaskManager
//
//  Created by Khateeb H. on 10/3/21.
//

import Foundation
import UIKit
import CoreData

final class DataManager {
    enum DataManagerError: Error {
        case invalidContext
    }
    static let shared: DataManager = DataManager()
    private var managedContext: NSManagedObjectContext? = nil
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        self.managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func fetchGarments() -> Result<[Garment], Error> {
        let fetchRequest = NSFetchRequest<Garment>(entityName: "Garment")
        
        guard let managedContext = self.managedContext else {
            return .failure(DataManagerError.invalidContext)
        }
        
        do{
            let items = try managedContext.fetch(fetchRequest)
            return .success(items)
        } catch let fetchErr{
            print("Failed to fetch items: ", fetchErr)
            return .failure(fetchErr)
        }
    }
    
    func saveNewGarment(id: UUID, title: String, createdDate: Date, completion: @escaping(Result<Garment, Error>) -> Void) {
        guard let context = managedContext else {
            return
        }
        let item = Garment(context: context)
        item.id = id
        item.title = title
        item.createdDate = createdDate
        
        do {
            try context.save()
            completion(.success(item))
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(.failure(error))
        }
    }
    
    func deleteGarment(by id: UUID) {
        let fetchRequest = NSFetchRequest<Garment>(entityName: "Garment")
        
        guard let managedContext = self.managedContext else {
            return
        }
        
        if let result = try? managedContext.fetch(fetchRequest) {
            for item in result {
                if item.id == id {
                    managedContext.delete(item)
                    do {
                        try managedContext.save()
                        return
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                        return
                    }
                }
            }
        }
    }
    
    func updateGarment(by id: UUID, title: String, createdDate: Date) {
        let fetchRequest = NSFetchRequest<Garment>(entityName: "Garment")
        
        guard let managedContext = self.managedContext else {
            return
        }
        
        if let result = try? managedContext.fetch(fetchRequest) {
            for item in result {
                if item.id == id {
                    item.title = title
                    item.createdDate = createdDate
                    do {
                        try managedContext.save()
                        return
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                        return
                    }
                }
            }
        }
    }
}
