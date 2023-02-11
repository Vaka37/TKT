//
//  ModelRow.swift
//  TKT
//
//  Created by Kalandarov Vakil on 10.02.2023.
//

import Foundation

struct ModelRow:Hashable,Decodable {
    var id = UUID()
    var title: String
    var phoneNumber: String
}
