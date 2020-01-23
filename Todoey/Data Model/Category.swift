//
//  Category.swift
//  Todoey
//
//  Created by Fahad Ali on 22/01/2020.
//  Copyright © 2020 Larasoft. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
}
