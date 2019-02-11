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
    var todoList = TodoListData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TodoListControllerKeys.cellReuseIdentifier)
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListControllerKeys.cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = todoList.item(at: indexPath.row)
        cell.setAccessory(.checkmark, enabled: todoList.isItemSelected(at: indexPath.row))
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoList.toggleSelection(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: indexPath)?.toggleAccessory(.checkmark)
    }
    
    // MARK: - Add New Item
    @IBAction func addNewItemButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Todoey Item", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let alertTextField: UITextField = alert.textFields![0] as UITextField
            if alertTextField.text != "" {
                self.todoList.addItem(alertTextField.text!)
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
        todoList.searchItem(searchText)
        tableView.reloadData()
    }
}

