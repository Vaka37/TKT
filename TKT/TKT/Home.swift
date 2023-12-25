//
//  Home.swift
//  TKT
//
//  Created by Kalandarov Vakil on 24.12.2022.
//

import SwiftUI

struct Home : View {
    @EnvironmentObject var dataManager : DataManager
    private let settingsUser = SettingsUser.shared
    @State private var showViewNewOrder = false
    @State private var closeAccauntView = false
    var body : some View{
        VStack{
            List{
                ForEach(Array(dataManager.myOrder.enumerated()), id:\.1){index, item in
                    NavigationLink(destination: DetailOrder(item: item), label: {
                        OrderRow(model: item, numberItem: index + 1)
                    })
                }.onDelete(perform: delete)
            }
            Button("Exit"){
                deleteUserDefaultInfo()
                closeAccauntView.toggle()
                }
            Text(settingsUser.modelUser?.nameUser ?? "dima")
        }.navigationTitle("Home")
            .navigationBarItems(trailing:
                                    HStack{
                Text("Баланс").padding(.horizontal)
                Button(action: {
                    self.showViewNewOrder.toggle()
                }, label: {
                    Image(systemName: "plus.app")
                })
            }
            ).sheet(isPresented: $showViewNewOrder, content: {
                NewOrder()
            }).fullScreenCover(isPresented: $closeAccauntView, content: {
                ContentView()
            })
    }
    
    func deleteUserDefaultInfo(){
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    private func delete(with indexSet: IndexSet) {
        indexSet.forEach {
            dataManager.myOrder.remove(at: $0)
        }
    }
}
