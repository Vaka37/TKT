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
        HStack(spacing: 5){
            Text(String(numberItem))
            Text(model.from)
            Image(systemName: "arrow.forward")
            Text(model.to)
            Spacer()
            if model.weidth != ""{
            Image(systemName: "scalemass")
                Text("\(model.weidth): кг")
            }
        }
    }
}

