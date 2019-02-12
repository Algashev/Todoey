//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Александр Алгашев on 11/02/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

private struct CategoryControllerKeys {
    static let cellReuseIdentifier: String = "CategoryCell"
}

class CategoryViewController: UITableViewController {
    var todoCategories = TodoListData(entityName: "Category")

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CategoryControllerKeys.cellReuseIdentifier)
    }

    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryControllerKeys.cellReuseIdentifier, for: indexPath)
        let category = todoCategories.data(at: indexPath.row) as! Category
        cell.textLabel?.text = category.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoCategories.count
    }

    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let todoListViewController = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            let category = todoCategories.data(at: indexPath.row) as! Category
            todoListViewController.selectedCategory = category
        }
    }

    @IBAction func addNewCategoryButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Todoey Category", message: "Select new category name", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let alertTextField: UITextField = alert.textFields![0] as UITextField
            if alertTextField.text != "" {
                let category = Category(context: self.todoCategories.context)
                category.name = alertTextField.text!
                self.todoCategories.addData(category)
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category..."
        }
        alert.addAction(alertAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        present(alert, animated: true, completion: nil)
    }
}
