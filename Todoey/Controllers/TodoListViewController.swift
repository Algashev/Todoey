//
//  ViewController.swift
//  Todoey
//
//  Created by Александр Алгашев on 07/02/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

struct TodoListKeys {
    static let defaultsItems: String = "TodoListItems"
}

class TodoListViewController: UITableViewController {
    var items: [Item] = [Item("Find Mike"), Item("Buy Eggos"), Item("Destroy Demogorgon")]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
//       Do any additional setup after loading the view, typically from a nib.
//        if let defaultsItems = defaults.array(forKey: TodoListKeys.defaultsItems) as? [String] {
//            items = defaultsItems
//        }
    }
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        cell.setAccessory(.checkmark, enabled: items[indexPath.row].selected)
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].selected.toggle()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: indexPath)?.toggleAccessory(.checkmark)
    }
    
    // MARK: - Add New Item
    @IBAction func addNewItemButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Todoey Item", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let alertTextField: UITextField = alert.textFields![0] as UITextField
            if alertTextField.text != "" {
                self.items.append(Item(alertTextField.text!))
//                self.defaults.set(self.items, forKey: TodoListKeys.defaultsItems)
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item..."
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

