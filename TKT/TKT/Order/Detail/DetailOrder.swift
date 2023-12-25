//
//  DetailOrder.swift
//  TKT
//
//  Created by Kalandarov Vakil on 10.02.2023.
//

import Foundation
import SwiftUI

struct DetailOrder: View{
    @EnvironmentObject var dataManager : DataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var deleteOrderAlert = false
    var item:  ModelRow
    var settingUser = SettingsUser.shared
    var body: some View{
        VStack{
            if item.accountEmail == settingUser.modelUser?.emailUser{
                Text(item.accountEmail)
            }
            Text(item.from)
            Text(item.to)
            Text(item.description)
            Text(item.id)
            Spacer()
            if item.accountEmail == settingUser.modelUser?.emailUser{
                Button("Delete Order"){
                    deleteOrderAlert.toggle()
                }
            }
        }.alert(isPresented: $deleteOrderAlert) {
            Alert(title: Text("Внимание"), message: Text("Точно хочешь удалить данный заказ?"), primaryButton: .default(Text("Неа")), secondaryButton: .cancel(Text("Точно"), action: {
                dataManager.deleteDocuments(order: item.id)
                presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}
