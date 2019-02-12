//
//  ItemsCollection.swift
//  Todoey
//
//  Created by Александр Алгашев on 09/02/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit
import CoreData

class TodoListData {
    private var data = [Any]()
    private var category: String?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var count: Int {
        get {
            return data.count
        }
    }
    
    init(entityName name: String) {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: name)
        loadData(with: request)
    }
    init(entityName name: String, category: String) {
        self.category = category
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: name)
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", category)
        request.predicate = predicate
        loadData(with: request)
    }
    
    func data(at index: Int) -> Any {
        return data[index]
    }
    func addData(_ data: Any) {
        self.data.append(data)
        _ = saveData()
    }
    func searchItem(_ searchText: String) {
        let request: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", category!)
        if searchText != "" {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate,  NSPredicate(format: "title CONTAINS[cd] %@", searchText)])
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        } else {
            request.predicate = predicate
        }
        loadData(with: request)
    }
    private func loadData(with request: NSFetchRequest<NSFetchRequestResult>) {
        do {
            data = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
    }
    func saveData() -> Bool {
        do {
            try context.save()
            return true
        } catch {
            print("Error saving context: \(error)")
            return false
        }
    }
}
