//
//  SettinsNewOrder.swift
//  TKT
//
//  Created by Kalandarov Vakil on 25.12.2023.
//

import Foundation


class SettingsNewOrder:ObservableObject{
    static let shared = SettingsNewOrder()
    private let settingsUser = SettingsUser.shared
    private var dataManager = DataManager.shared
    private init(){}
    
    @Published var from = ""
    @Published var to = ""
    @Published var weight = ""
    @Published var description = ""
    @Published var rate = ""
    @Published var tonnage = ""
    @Published var volume = ""
    
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
        tonnage = ""
        volume = ""
    }
    
    func createNewOrder() {
        let orderModel = ModelRow(id: UUID().uuidString, from: from, to: to, weidth: weight, description: description, accountEmail: settingsUser.modelUser?.emailUser ?? "", rate: Int(rate) ?? 0, date: Date(),tonnage: tonnage,volume: volume)
        dataManager.addNewDataOrder(modelOrder: orderModel)
    }
}
