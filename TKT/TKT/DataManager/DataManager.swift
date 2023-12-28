//
//  DataManager.swift
//  TKT
//
//  Created by Kalandarov Vakil on 12.02.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase


class DataManager: ObservableObject{
    @Published var orderModel: [ModelRow] = []
    @Published var myOrder: [ModelRow] = []
    static var shared = DataManager()
    
   private init(){
    }
    //MARK: - забрать вссе заказы
    func fetchDataOrder() {
        orderModel.removeAll()
        myOrder.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("order")
        ref.getDocuments(completion: {snapshot, error in
            guard error == nil else {
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let identefire = document.documentID
                    let from = data["from"] as? String ?? ""
                    let to = data["to"] as? String ?? ""
                    let weight = data["weight"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let accaunt = data["accauntEmail"] as? String ?? ""
                    let rate = data["rate"] as? Int ?? 0
                    let date = data["date"] as? Date ?? Date()
                    let tonnage = data["tonnage"] as? String ?? ""
                    let volume = data["volume"] as? String ?? ""
                    let order = ModelRow(id: identefire, from: from, to: to, weidth: weight, description: description, accountEmail: accaunt, rate: rate, date: date,tonnage: tonnage,volume: volume)
                    self.orderModel.append(order)
                    if accaunt == SettingsUser.shared.modelUser?.emailUser {
                        self.myOrder.append(order)
                    }
                }
            }
        })
    }
    //MARK: - забрать данные пользователяя
    func fetchUserDataOrder(modelUser: ModelUser) {
        fetchDataOrder()
        let db = Firestore.firestore()
        let ref = db.collection("UserDataBase")
        ref.getDocuments(completion: {snapshot, error in
            guard error == nil else {
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let email = data["emailUser"] as? String ?? ""
                    if email == modelUser.emailUser{
                        let name = data["nameUser"] as? String ?? ""
                        let password = data["passwordUser"] as? String ?? ""
                        let user = ModelUser(nameUser: name, emailUser: email, passwordUser: password)
                        SettingsUser.shared.modelUser = user
                    }
                }
            }
        })
    }
    
    func deleteDocuments(order id: String){
        let db = Firestore.firestore()
        do {
          try  db.collection("order").document(id).delete()
          print("Document successfully removed!")
        } catch {
          print("Error removing document: \(error)")
        }
    }
    
//MARK: - создать новый заказ
    func addNewDataOrder(modelOrder: ModelRow) {
        let db = Firestore.firestore()
              do {
                  _ = try db.collection("order").document(modelOrder.id).setData(["from": modelOrder.from,"to": modelOrder.to, "weight": modelOrder.weidth,"description":modelOrder.description,"accauntEmail":modelOrder.accountEmail,"rate": modelOrder.rate,"date":modelOrder.date.description,"tonnage": modelOrder.tonnage,"volume" :modelOrder.volume])
                  fetchDataOrder()
              }
              catch {
                  print(error.localizedDescription)
              }
          }
    //MARK: - создать нового пользователя
    func addNewUser(modelUser: ModelUser) {
        let db = Firestore.firestore()
              do {
                  _ = try db.collection("UserDataBase").addDocument(data: ["nameUser": modelUser.nameUser,"emailUser": modelUser.emailUser, "passwordUser": modelUser.passwordUser])
              }
              catch {
                  print(error.localizedDescription)
              }
          }
    
}
