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
            .refreshable {
                dataManager.fetchDataOrder()
                //print{"Refresh"}
            }
            .listStyle(PlainListStyle())
                .navigationTitle(Text("Заказы"))
                .navigationBarItems(trailing:
                                        HStack{
                    Button {
                       // dataManager.fetchDataOrder()
                    } label: {
                        Image(systemName: "slowmo")
                    }
                    NavigationLink(destination: Home(), label: {
                        Image(systemName: "person.crop.circle")
                    }
                    )})
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    private func delete(with indexSet: IndexSet) {
        indexSet.forEach { dataManager.orderModel.remove(at: $0) }
    }
    
}
