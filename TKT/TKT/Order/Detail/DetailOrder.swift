//
//  DetailOrder.swift
//  TKT
//
//  Created by Kalandarov Vakil on 10.02.2023.
//

import Foundation
import SwiftUI

struct DetailOrder: View{
    var item:  ModelRow
    var body: some View{
        Text(item.title)
    }
}
