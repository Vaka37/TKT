//
//  NewOrder.swift
//  TKT
//
//  Created by Kalandarov Vakil on 25.12.2023.
//

import SwiftUI

struct NewOrder: View {
    @StateObject var settingNewOrder = SettingsNewOrder.shared
    
    var body: some View {
        VStack{
            Text("Создайте новый заказ")
                .fontWeight(.heavy).font(.largeTitle)
                .padding()
                .lineLimit(1)
            VStack(alignment: .leading){
                Text("Откуда")
                TextField("Введите где забрать", text: $settingNewOrder.from).textFieldStyle(.roundedBorder)
                Text("Куда")
                TextField("Введите куда везем", text: $settingNewOrder.to).textFieldStyle(.roundedBorder)
                Text("Вес груза")
                TextField("Введите сколлько вессит груз", text: $settingNewOrder.weight).textFieldStyle(.roundedBorder)
            }
            Spacer().frame(height: 50)
            Button {
                
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
    }
}
