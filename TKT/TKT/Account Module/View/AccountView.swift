//
//  Home.swift
//  TKT
//
//  Created by Kalandarov Vakil on 24.12.2022.
//

import SwiftUI


//TODO: - старая реаизация
//struct Home : View {
//    @EnvironmentObject var dataManager : DataManager
//    private let settingsUser = SettingsUser.shared
//    @State private var showViewNewOrder = false
//    @State private var closeAccauntView = false
//    var body : some View{
//        NavigationView{
//            VStack{
//                List{
//                    ForEach(Array(dataManager.myOrder.enumerated()), id:\.1){index, item in
//                        NavigationLink(destination: DetailOrder(item: item), label: {
//                            OrderRow(model: item, numberItem: index + 1)
//                        })
//                    }.onDelete(perform: delete)
//                }
//                Button("Exit"){
//                    deleteUserDefaultInfo()
//                    closeAccauntView.toggle()
//                }
//                Text(settingsUser.modelUser?.nameUser ?? "dima")
//            }.navigationTitle("Home")
//                .navigationBarItems(trailing:
//                                        HStack{
//                    Text("Баланс").padding(.horizontal)
//                    NavigationLink(destination: NewOrder(), label: {
//                        Image(systemName: "plus.app")
//                    })
//                }
//                ).fullScreenCover(isPresented: $closeAccauntView, content: {
//                    ContentView()
//                })
//        }
//    }
//
//    func deleteUserDefaultInfo(){
//        let defaults = UserDefaults.standard
//        let dictionary = defaults.dictionaryRepresentation()
//        dictionary.keys.forEach { key in
//            defaults.removeObject(forKey: key)
//        }
//    }
//    private func delete(with indexSet: IndexSet) {
//        indexSet.forEach {
//            dataManager.myOrder.remove(at: $0)
//        }
//    }
//}

struct Account: View {
    // MARK: - Constants
    
    private enum Constants {
        static let profileTitle = "Аккаунт"
        static let accountTitle = "Информация об аккаунту"
        static let myOrderTitle = "Мои Заказы"
    }
    
    @State private var accountSelected = false
    @State private var isMyOrderView = false
    private let settingsUser = SettingsUser.shared
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text(Constants.profileTitle)
                        .padding()
                    Spacer()
                }
                profileInfo
                ZStack{
                    if accountSelected {
                        accountDetailView
                    }  else if isMyOrderView {
                        myOrder
                    } else {
                        setingsProfile
                    }
                }
                Spacer()
            }
            .navigationBarItems(trailing:
                                    NavigationLink(destination: NewOrder(), label: {
                Image(systemName: "plus.app")
            })
            )
        }
    }
    
    private var profileInfo: some View {
        VStack{
            HStack {
                Image("Avatar")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .cornerRadius(50)
                Spacer()
                    .frame(width: 30)
                Text(settingsUser.modelUser?.nameUser ?? "noName")
                Spacer()
            }
            .padding()
            Divider()
                .padding(.horizontal)
        }
    }
    
    /// Ячейки с настройками аккаунта
    private var settingsItems = ["Аккаунт", Constants.myOrderTitle, "About"]
    
    private var setingsProfile: some View {
        VStack{
            makeRowProfile(icon: settingsItems[0], header: settingsItems[0]) {
                withAnimation(.linear) {
                    accountSelected.toggle()
                }
            }
            makeRowProfile(icon: settingsItems[1], header: settingsItems[1]) {
                withAnimation(.linear) {
                    isMyOrderView.toggle()
                }
            }
            makeRowProfile(icon: settingsItems[2], header: settingsItems[2]) {
                
            }
        }
    }
    
    /// Создание ячейки юзера
    /// - Parameters:
    /// - icon: Имя иконки
    /// - header: Имя ячейки
    /// - actionHandler: Вью на которое переходим
    private func makeRowProfile(icon: String, header: String, actionHandler: (() -> ())?) -> some View {
        HStack {
            Button {
                actionHandler?()
            } label: {
                Image(icon)
                Text(header)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.gray.opacity(0.9))
        }
        .padding()
    }
    
    private func makeBackRow(header: String) ->some View {
        HStack {
            Image(systemName: "chevron.left")
                .foregroundColor(Color("tintColor"))
            Text(header)
                .foregroundColor(.gray.opacity(0.9))
            Spacer()
        }
        .padding()
    }
    
    /// Вью с детальной информацие об аккаунте
    private var accountDetailView: some View {
        VStack {
            Button(action: {
                withAnimation() {
                    accountSelected.toggle()
                }
            }, label: {
                makeBackRow(header: Constants.accountTitle)
            })
        }.transition(.slide)
    }
    
    /// Вью с заказами аккаунта
    private var myOrder: some View {
        VStack {
            Button(action: {
                withAnimation() {
                    isMyOrderView.toggle()
                }
            }, label: {
                makeBackRow(header: Constants.myOrderTitle)
            })
        }.transition(.slide)
    }
    
}

#Preview {
    Account()
}
