//
//  Data.swift
//  Todoey
//
//  Created by Pius Asare on 16/12/2018.
//  Copyright © 2018 PapayaLabz. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    //Tells the runtime to use dynamic dispatch instead of static dispatch
    //Allows this property to be changed at runtime
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
