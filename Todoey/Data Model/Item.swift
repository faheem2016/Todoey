//
//  Item.swift
//  Todoey
//
//  Created by Fahad Ali on 22/01/2020.
//  Copyright © 2020 Larasoft. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
