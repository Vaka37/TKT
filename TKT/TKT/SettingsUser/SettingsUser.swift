//
//  SettingsUser.swift
//  TKT
//
//  Created by Kalandarov Vakil on 11.02.2023.
//

import Foundation
import SwiftUI
import FirebaseDatabase


class SettingsUser:ObservableObject{
    static let shared = SettingsUser()
    @Published var nameUser: String = ""
    @Published var loginTextField: String = ""
    @Published var passwordTextField: String = ""
    @Published var message = ""
    @Published var modelUser: ModelUser?
    
    private init(){}
    func setUpDatabase() {
        Database.database().reference().observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value, JSONSerialization.isValidJSONObject(value) else {
                return
            }
            do {
                let data = try JSONSerialization.data(withJSONObject: value)
              //  let labels = try JSONDecoder().decode(ModelRow.self, from: data)
            } catch let error {
                print(error)
                
            }
        }) { error in
        }
    }
}
