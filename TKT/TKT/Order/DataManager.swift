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
    
    init(){
        fetchDataOrder()
    }
    
    func fetchDataOrder() {
        orderModel.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("order")
        ref.getDocuments(completion: {snapshot, error in
            guard error == nil else {
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let from = data["from"] as? String ?? ""
                    let to = data["to"] as? String ?? ""
                    let weight = data["weight"] as? String ?? ""
                    let order = ModelRow(from: from, to: to, weidth: weight)
                    self.orderModel.append(order)
                }
            }
        })
    }
}
