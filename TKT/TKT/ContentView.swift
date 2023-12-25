//
//  ContentView.swift
//  TKT
//
//  Created by Kalandarov Vakil on 24.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var modelUser = SettingsUser.shared
    var body: some View {
        VStack{
            if status{
                OrderView()
            }else{
                SignIniew()
            }
        }
        .onAppear {
            var name = ""
            var loginTextField = ""
            let password = ""
            for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                switch key {
                case "status":
                    self.status = value as? Bool ?? false
                case "nameUser":
                    name = value as? String ?? "Unt"
                case "emailUser":
                    loginTextField = value as? String ?? "Unt"
                default:
                    break
                }
            }
            //MARK: - пароль еще не устанавливал, пароли в юзер дефолте не хранят использовать кей чей
            modelUser.modelUser = ModelUser(nameUser: name, loginTextField: loginTextField, passwordTextField: "123456")
        }
    }
}


