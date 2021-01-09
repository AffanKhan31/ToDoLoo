//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by affan khan on 2020-12-29.
//

import Foundation
import CoreData

class ToDoListItem: NSManagedObject, Identifiable {
    @NSManaged var name: String?
    @NSManaged var createdAt: Date?
}

extension ToDoListItem {
    static func getAllToDoListItem() -> NSFetchRequest<ToDoListItem> {
    let request: NSFetchRequest<ToDoListItem> =
    ToDoListItem.fetchRequest() as!
    NSFetchRequest<ToDoListItem>
        
        let sort = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sort]
        
        return request
    }
}
