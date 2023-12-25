//
//  ContentView.swift
//  TKT
//
//  Created by Kalandarov Vakil on 24.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @EnvironmentObject var dataManager : DataManager
    var body: some View {
        VStack{
            if status{
                OrderView()
            }else{
                SignIniew()
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status}
            var name = ""
            var loginTextField = ""
            let password = ""
            for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                switch key {
                case "nameUser":
                    name = value as? String ?? "Unt"
                case "emailUser":
                    loginTextField = value as? String ?? "Unt"
                default:
                    break
                }
            }
            //MARK: - пароль еще не устанавливал, пароли в юзер дефолте не хранят использовать кей чей
           let user = ModelUser(nameUser: name, emailUser: loginTextField, passwordUser: "123456")
            dataManager.fetchUserDataOrder(modelUser: user)
        }
    }
}


