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
    @Published var description = ""
    @Published var rate = ""
    
    func valideForm() -> Bool {
        if from != "" ,to != "",weight != "",rate != ""{
            return false
        }
        return true
    }
    func clearForm() {
        from = ""
        to = ""
        weight = ""
        description = ""
        rate = ""
    }
}
