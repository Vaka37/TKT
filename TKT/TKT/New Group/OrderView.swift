//
//  OrderView.swift
//  TKT
//
//  Created by Kalandarov Vakil on 10.02.2023.
//

import Foundation
import SwiftUI


struct OrderView: View{
    
    @EnvironmentObject var dataManager : DataManager
    
    var body: some View{
        NavigationView{
            List{
                ForEach(Array(dataManager.orderModel.enumerated()), id:\.1){index, item in
                    NavigationLink(destination: DetailOrder(item: item), label: {
                        OrderRow(model: item, numberItem: index + 1)
                    })
                }
                .onDelete(perform: delete)
            }
            .navigationTitle(Text("Заказы"))
            .navigationBarItems(trailing:
                                    NavigationLink(destination: Home(), label: {
                Image(systemName: "person.crop.circle")
            })
            )
        }
    }
    private func delete(with indexSet: IndexSet) {
        indexSet.forEach { dataManager.orderModel.remove(at: $0) }
    }

}
