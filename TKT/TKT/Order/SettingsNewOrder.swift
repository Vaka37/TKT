//
//  SettinsNewOrder.swift
//  TKT
//
//  Created by Kalandarov Vakil on 25.12.2023.
//

import Foundation


class SettingsNewOrder:ObservableObject{
    static let shared = SettingsNewOrder()
    private init(){}
    
    @Published var from = ""
    @Published var to = ""
    @Published var weight = ""
    
    func valideForm() -> Bool {
        if from != "" ,to != "",weight != ""{
            return false
        }
        return true
    }
}
