//
//  Home.swift
//  TKT
//
//  Created by Kalandarov Vakil on 24.12.2022.
//

import SwiftUI

struct Home : View {
    @StateObject var settingsUser = SettingsUser()
    
    var body : some View{
        VStack{
            Text("Home")
            Text(settingsUser.nameUser)
            Button(action: {
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            }) {
                
                Text("Выйти")
            }
        }
    }
}
