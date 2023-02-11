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
    @Published var nameUser: String = ""
    @Published var loginTextField: String = ""
    @Published var passwordTextField: String = ""
    @Published var message = ""
    
    
    func setUpDatabase() {
        Database.database().reference().observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value, JSONSerialization.isValidJSONObject(value) else {
                // no JSON data received
                return
            }
            do {
                let data = try JSONSerialization.data(withJSONObject: value)
                let labels = try JSONDecoder().decode(ModelRow.self, from: data)
                // Labels are ready to use in the app
            } catch let error {
                print(error)
                
            }
        }) { error in
            // handle Firebase error
        }
    }
    
}
