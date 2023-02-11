//
//  OrderView.swift
//  TKT
//
//  Created by Kalandarov Vakil on 10.02.2023.
//

import Foundation
import SwiftUI


struct OrderView: View{
    @State var array = [ModelRow(title: "1", phoneNumber: "89611160000"),ModelRow(title: "2", phoneNumber: "89611160000"),ModelRow(title: "3", phoneNumber: "89611160000"),ModelRow(title: "4", phoneNumber: "89611160000"),ModelRow(title: "5", phoneNumber: "89611160000"),ModelRow(title: "6", phoneNumber: "89611160000"),ModelRow(title: "7", phoneNumber: "89611160000")]
    
    var body: some View{
        NavigationView{
            List{
                ForEach(Array(array.enumerated()), id:\.1){index, item in
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
        indexSet.forEach { array.remove(at: $0) }
    }

}
