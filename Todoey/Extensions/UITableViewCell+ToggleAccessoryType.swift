//
//  UITableViewCell+ToggleAccessoryType.swift
//  Todoey
//
//  Created by Александр Алгашев on 08/02/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func toggleAccessory(_ accessory: UITableViewCell.AccessoryType) {
        self.accessoryType = (self.accessoryType == .none ? accessory : .none)
    }
}
