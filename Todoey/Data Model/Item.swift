//
//  Item.swift
//  Todoey
//
//  Created by Pius Asare on 02/12/2018.
//  Copyright © 2018 PapayaLabz. All rights reserved.
//

import Foundation

class Item: Codable {//Encodable, Decodable {
    var title: String = ""
    var done: Bool = false
}
