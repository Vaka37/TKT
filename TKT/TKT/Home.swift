//
//  Home.swift
//  TKT
//
//  Created by Kalandarov Vakil on 24.12.2022.
//

import SwiftUI

struct Home : View {
    private let settingsUser = SettingsUser.shared
    @State private var showViewNewOrder = false
    
    var body : some View{
        VStack{
            Button("Exit"){deleteUserDefaultInfo()}
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
            })
    }
    
    func deleteUserDefaultInfo(){
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
