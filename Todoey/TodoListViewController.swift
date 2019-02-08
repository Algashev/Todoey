//
//  ViewController.swift
//  Todoey
//
//  Created by Александр Алгашев on 07/02/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var items = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("indexPath.row = \(indexPath.row)")
//        print("value: \(items[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: indexPath)?.toggleAccessory(.checkmark)
    }
    
    // MARK: - Add New Item
    @IBAction func addNewItemButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Todoey Item", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Alert Action Done: \"\(action.title ?? "")\"")
            let alertTextField: UITextField = alert.textFields![0] as UITextField
            if alertTextField.text != "" {
                print("alertTextField.text = \(alertTextField.text!)")
                self.items.append(alertTextField.text!)
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

