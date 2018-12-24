//
//  Category.swift
//  Todoey
//
//  Created by Pius Asare on 17/12/2018.
//  Copyright © 2018 PapayaLabz. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
