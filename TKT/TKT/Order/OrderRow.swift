//
//  OrderRow.swift
//  TKT
//
//  Created by Kalandarov Vakil on 10.02.2023.
//

import SwiftUI

struct OrderRow: View,Identifiable {
    var id = UUID()
    var model: ModelRow
    var numberItem: Int
    
    var body: some View {
        Button {
        } label: {
            HStack{
                Text(String(numberItem))
                    Text(model.from)
                    Text("----->")
                    Text(model.to)
            }
        }
    }
}

