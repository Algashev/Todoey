//
//  Item.swift
//  Todoey
//
//  Created by Александр Алгашев on 09/02/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import Foundation

class Item: Codable {
    var title: String = ""
    var selected: Bool = false
    
    init(_ title: String) {
        self.title = title
    }
}
