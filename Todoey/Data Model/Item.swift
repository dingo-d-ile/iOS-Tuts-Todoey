//
//  Item.swift
//  Todoey
//
//  Created by Pius Asare on 17/12/2018.
//  Copyright © 2018 PapayaLabz. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
