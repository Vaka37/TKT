//
//  NewOrder.swift
//  TKT
//
//  Created by Kalandarov Vakil on 25.12.2023.
//

import SwiftUI

struct NewOrder: View {
    @StateObject var settingNewOrder = SettingsNewOrder.shared
    private let settingsUser = SettingsUser.shared
    private var dataManager = DataManager.shared
    @State private var placeholder = "Введите подробности заказа"
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack{
            Text("Создайте новый заказ")
                .fontWeight(.semibold).font(.title)
                .padding()
                .lineLimit(1)
            VStack(alignment: .leading){
                Text("Откуда")
                TextField("Введите где забрать", text: $settingNewOrder.from).textFieldStyle(.roundedBorder)
                Text("Куда")
                TextField("Введите куда везем", text: $settingNewOrder.to).textFieldStyle(.roundedBorder)
                Text("Вес груза : кг")
                TextField("Введите сколлько весит груз", text: $settingNewOrder.weight).textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                Text("Цена : руб")
                TextField("Введите ставку", text: $settingNewOrder.rate).textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextEditorWithPlaceholder(text: $settingNewOrder.description)
            }
            Spacer().frame(height: 50)
            Button {
                if settingNewOrder.valideForm(){
                    showAlert.toggle()
                }else{
                    let orderModel = ModelRow(id: UUID().uuidString, from: settingNewOrder.from, to: settingNewOrder.to, weidth: settingNewOrder.weight, description: settingNewOrder.description, accountEmail: settingsUser.modelUser?.emailUser ?? "", rate: Int(settingNewOrder.rate) ?? 0)
                    dataManager.addNewDataOrder(modelOrder: orderModel)
                    self.presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("создать")
            }
            .foregroundColor(.green)
            .buttonStyle(.automatic)
            .frame(width: 130, height: 90)
            Spacer().frame(height: 50)
            
        }.onTapGesture {
            hideKeyboard()
        }.padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("поля не могут быть пустыми"), message: Text("Введите данные"), dismissButton: .default(Text("OK")))
            }.onDisappear(perform: {
                settingNewOrder.clearForm()
            })
    }
}

struct TextEditorWithPlaceholder: View {
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                VStack {
                    Text("Введите подробности заказа...")
                        .padding(.top, 10)
                        .padding(.leading, 6)
                        .opacity(0.6)
                    Spacer()
                }
            }
            VStack {
                TextEditor(text: $text)
                    .frame(minHeight: 150, maxHeight: 300)
                    .opacity(text.isEmpty ? 0.85 : 1)
                Spacer()
            }
        }
    }
}
