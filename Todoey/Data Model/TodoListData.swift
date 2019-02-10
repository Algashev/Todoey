//
//  ItemsCollection.swift
//  Todoey
//
//  Created by Александр Алгашев on 09/02/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import Foundation

private struct TodoListDataKeys {
    static let dataFilePath: URL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist"))!
}

class TodoListData {
    private var items = [Item]()
    var count: Int {
        get {
            return items.count
        }
    }
    
    init() {
        if let data = try? Data(contentsOf: TodoListDataKeys.dataFilePath) {
            let decoder = PropertyListDecoder()
            do {
                items = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding items: \(error)")
            }
        }
    }
    
    func item(at index: Int) -> String {
        return items[index].title
    }
    func isItemSelected(at index: Int) -> Bool {
        return items[index].selected
    }
    func toggleSelection(at index: Int) {
        items[index].selected.toggle()
        _ = saveItems()
    }
    func append(_ item: Item) {
        items.append(item)
        _ = saveItems()
    }
    func saveItems() -> Bool {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(items)
            try data.write(to: TodoListDataKeys.dataFilePath)
//            print(TodoListDataKeys.dataFilePath)
            return true
        } catch {
            print("Error encoding items: \(error)")
            return false
        }
    }
}
