//
//  NewOrder.swift
//  TKT
//
//  Created by Kalandarov Vakil on 25.12.2023.
//

import SwiftUI

struct NewOrder: View {
    @StateObject var settingNewOrder = SettingsNewOrder.shared
    private var dataManager = DataManager.shared
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
            }
            Spacer().frame(height: 50)
            Button {
                if settingNewOrder.valideForm(){
                    showAlert.toggle()
                }else{
                    dataManager.addNewData(from: settingNewOrder.from, to: settingNewOrder.to, weight: settingNewOrder.weight)
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
            }
    }
}
