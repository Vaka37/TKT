//
//  ModelRow.swift
//  TKT
//
//  Created by Kalandarov Vakil on 10.02.2023.
//

import Foundation

struct ModelRow:Hashable,Decodable {
    var id: String
    var from: String
    var to: String
    var weidth: String
    var description: String
    var accountEmail: String
    var rate: Int
    var date : Date
    var tonnage: String
    var volume : String
}
