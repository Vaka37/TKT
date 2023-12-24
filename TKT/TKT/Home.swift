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
            Text("Home")
            Text(settingsUser.nameUser)
            Button(action: {
                deleteUserDefaultInfo()
            }) {
                
                Text("Выйти")
            }
        }.navigationTitle("личная информация")
            .navigationBarItems(trailing:
                                    Button(action: {
                self.showViewNewOrder.toggle()
            }, label: {
                Image(systemName: "plus.app")
            })).sheet(isPresented: $showViewNewOrder, content: {
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
