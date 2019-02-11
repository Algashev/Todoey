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
    private var items = [Item]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var count: Int {
        get {
            return items.count
        }
    }
    
    init() {
        loadItems()
    }
    
    func item(at index: Int) -> String {
        return items[index].title!
    }
    func isItemSelected(at index: Int) -> Bool {
        return items[index].selected
    }
    func toggleSelection(at index: Int) {
        items[index].selected.toggle()
        _ = saveItems()
    }
    func addItem(_ title: String) {
        let item = Item(context: context)
        item.title = title
        items.append(item)
        _ = saveItems()
    }
    func searchItem(_ searchText: String) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        if searchText != "" {
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        }
        loadItems(with: request)
    }
    private func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            items = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
    }
    private func saveItems() -> Bool {
        do {
            try context.save()
            return true
        } catch {
            print("Error saving context: \(error)")
            return false
        }
    }
}
