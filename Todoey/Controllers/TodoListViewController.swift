//
//  ViewController.swift
//  Todoey
//
//  Created by Александр Алгашев on 07/02/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

private struct TodoListControllerKeys {
    static let cellReuseIdentifier: String = "ToDoItemCell"
}

class TodoListViewController: UITableViewController {
    var todoItems: TodoListData?
    var selectedCategory: Category? {
        didSet {
            todoItems = TodoListData(entityName: "Item", category: (selectedCategory?.name)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TodoListControllerKeys.cellReuseIdentifier)
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListControllerKeys.cellReuseIdentifier, for: indexPath)
        let item = todoItems!.data(at: indexPath.row) as! Item
        cell.textLabel?.text = item.title
        cell.setAccessory(.checkmark, enabled: item.selected)
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (todoItems?.count)!
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = todoItems!.data(at: indexPath.row) as! Item
        item.selected.toggle()
        _ = todoItems!.saveData()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: indexPath)?.toggleAccessory(.checkmark)
    }
    
    // MARK: - Add New Item
    @IBAction func addNewItemButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Todoey Item", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let alertTextField: UITextField = alert.textFields![0] as UITextField
            if alertTextField.text != "" {
                let item = Item(context: self.todoItems!.context)
                item.title = alertTextField.text!
                item.parentCategory = self.selectedCategory
                self.todoItems!.addData(item)
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

// MARK: -
extension TodoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        todoItems!.searchItem(searchText)
        tableView.reloadData()
    }
}

