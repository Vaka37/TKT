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
        ScrollView{
            VStack{
                VStack(alignment: .leading){
                    HStack{
                        VStack{
                            Text("Откуда")
                            TextField("Где забрать", text: $settingNewOrder.from).textFieldStyle(.roundedBorder)
                        }
                        VStack{
                            Text("Куда")
                            TextField("Куда везем", text: $settingNewOrder.to).textFieldStyle(.roundedBorder)
                        }
                    }
                    HStack{
                        VStack{
                            Text("Вес груза : кг")
                            TextField("Сколько весит груз", text: $settingNewOrder.weight).textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                        }
                        VStack{
                            Text("Цена : руб")
                            TextField("Введите ставку", text: $settingNewOrder.rate).textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                        }
                    }
                    HStack{
                        VStack{
                            Text("Грузоподъемность: т")
                            TextField("Грузоподъемность: т", text: $settingNewOrder.tonnage).textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                        }
                        VStack{
                            Text("Объём кузова: м³")
                            TextField("Введите объем", text: $settingNewOrder.volume).textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                        }
                    }
                    TextEditorWithPlaceholder(text: $settingNewOrder.description).border(.black.opacity(0.3), width: 1).clipShape(Rectangle())
                }
                Spacer().frame(height: 50)
                Button {
                    if settingNewOrder.valideForm(){
                        showAlert.toggle()
                    }else{
                        settingNewOrder.createNewOrder()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("создать")
                }
                .foregroundColor(.green)
                .buttonStyle(.automatic)
                .frame(width: 130, height: 90)
                Spacer().frame(height: 50)
                
            }.navigationTitle("Создайте новый заказ")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(trailing:
                                        Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")}))
                .onTapGesture {
                    hideKeyboard()
                }.padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("поля не могут быть пустыми"), message: Text("Введите данные"), dismissButton: .default(Text("OK")))
                }.onDisappear(perform: {
                    settingNewOrder.clearForm()
                })
        }
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
