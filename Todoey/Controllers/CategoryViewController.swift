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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CategoryControllerKeys.cellReuseIdentifier)
    }

    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    @IBAction func addNewCategoryButtonPressed(_ sender: UIBarButtonItem) {
    }
}
