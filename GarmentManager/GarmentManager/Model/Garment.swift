//
//  Garment.swift
//  GarmentManager
//
//  Created by Khateeb H. on 12/1/21.
//

import Foundation
import CoreData

struct GarmentItem {
    var id: UUID
    var title: String
    var createdDate: Date
}

class Garment: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var title: String
    @NSManaged var createdDate: Date

    var garmentItem : GarmentItem {
       get {
           return GarmentItem(id: self.id, title: self.title, createdDate: self.createdDate)
        }
        set {
            self.id = newValue.id
            self.title = newValue.title
            self.createdDate = newValue.createdDate
        }
     }
}

