//
//  ContentView.swift
//  TKT
//
//  Created by Kalandarov Vakil on 24.12.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import UIKit

struct SignIniew: View {
    @StateObject var settingUser = SettingsUser.shared
    @EnvironmentObject var dataManager : DataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var message = ""
    @State var alert = false
    @State private var showPassword = false
    @State var show = false

    var body: some View {
        VStack{
            Text("Добро пожаловать! Рад видеть вас снова!")
                .fontWeight(.heavy).font(.largeTitle)
                .padding()
            VStack(alignment: .leading){
                TextField("Введите ваш e-mail", text: $settingUser.loginTextField)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.colorTextFields))
                    .keyboardType(.emailAddress)
                    .padding(.vertical)
                HStack {
                    if !showPassword{
                        SecureField("Введите ваш пароль", text: $settingUser.passwordTextField)
                        Button {
                            withAnimation{
                                showPassword.toggle()
                            }
                        } label: {
                            Image(systemName: "flashlight.off.fill").foregroundColor(.gray)
                        }.padding(.horizontal,10)
                        
                    }else{
                        TextField("Введите ваш пароль", text: $settingUser.passwordTextField)
                        Button {
                            withAnimation{
                                showPassword.toggle()
                            }
                        } label: {
                            Image(systemName: "flashlight.on.fill").foregroundColor(.gray).rotationEffect(.degrees(-90))
                        }.padding(.horizontal,10)
                    }
                  }.frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.colorTextFields))
            }.padding()
                .padding(.vertical)
            Button {
                signInWithEmail(email: self.settingUser.loginTextField, password: self.settingUser.passwordTextField) { verified, status in
                    if !verified {
                        self.message = status
                        self.alert.toggle()
                    }else{
                        createSaveUserDefaultAccaunt(name: settingUser.nameUser, email: settingUser.loginTextField)
                        let modelUser = ModelUser(nameUser: settingUser.nameUser, emailUser: settingUser.loginTextField, passwordUser: settingUser.passwordTextField)
                        dataManager.fetchUserDataOrder(modelUser: modelUser)
                    }
                }
            } label: {
                Text("Войти")
                    .padding()
                    .foregroundColor(.white)
            }.frame(width: 360).background(Color.black).cornerRadius(10).shadow(color: .black.opacity(0.7), radius: 10, x: 0, y: 5)
            .alert(isPresented: $alert) {
                Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("OK")))
            }
            Spacer()
            HStack{
                Text("Нет Аккаунта?")
                Button("Присоединиться"){
                    show.toggle()
                }
            }.sheet(isPresented: $show) {
                SignUp(show: self.show)
            }

        }.onTapGesture {
            hideKeyboard()
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(uiImage: UIImage(named: "navigationBackButton") ?? UIImage())
            }))
    }
}

struct SignUp: View{
    @StateObject var settingUser = SettingsUser.shared
    @EnvironmentObject var dataManager : DataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var nameUser: String = ""
    @State var loginTextField: String = ""
    @State var passwordTextField: String = ""
    @State var message = ""
    @State var alert = false
    @State var show = false
    
    var body: some View {
        VStack{
            Text("Регистрация")
                .fontWeight(.heavy).font(.largeTitle)
                .padding()
            VStack(alignment: .leading){
                Text("Имя")
                TextField("Введите ваше имя", text: $settingUser.nameUser).textFieldStyle(.roundedBorder)
                Text("e-mail")
                TextField("Введите ваш e-mail", text: $settingUser.loginTextField).textFieldStyle(.roundedBorder).keyboardType(.emailAddress)
                Text("Пароль")
                TextField("Введите ваш пароль", text: $settingUser.passwordTextField).textFieldStyle(.roundedBorder)
            }.padding()
            Spacer().frame(height: 50)
            Button {
                signUpWithEmail(email: self.settingUser.loginTextField, password: self.settingUser.passwordTextField) { verified, status in
                    if !verified {
                        self.message = status
                        debugPrint(message,"::::")
                        self.alert.toggle()
                    }else{
                        createSaveUserDefaultAccaunt(name: settingUser.nameUser, email: settingUser.loginTextField)
                        let modelUser = ModelUser(nameUser: settingUser.nameUser, emailUser: settingUser.loginTextField, passwordUser: settingUser.passwordTextField)
                        dataManager.addNewUser(modelUser: modelUser)
                        dataManager.fetchUserDataOrder(modelUser: modelUser)
                        self.show.toggle()
                    }
                }
            } label: {
                Text("Sign Up")
            }.alert(isPresented: $alert) {
                Alert(title: Text("Error"), message: Text(self.message.localized()), dismissButton: .default(Text("OK")))
            }
            .foregroundColor(.green)
            .buttonStyle(.automatic)
            .frame(width: 130, height: 90)
            Spacer().frame(height: 50)
            
        }.onTapGesture {
            hideKeyboard()
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(uiImage: UIImage(named: "navigationBackButton") ?? UIImage())
            }))
    }
    
}
func signInWithEmail(email: String, password: String,complition: @escaping(Bool,String) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password){ (res,error) in
        if error != nil{
            complition(false,(error?.localizedDescription)!)
            return
        }
        complition(true,(res?.user.email)!)
    }
}
func signUpWithEmail(email: String, password: String,complition: @escaping(Bool,String) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password){ (res,error) in
        if error != nil{
            complition(false,(error?.localizedDescription)!)
            return
        }
        complition(true,(res?.user.email)!)
    }
}
func createSaveUserDefaultAccaunt(name: String,email: String) {
        UserDefaults.standard.set(true, forKey: "status")
        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
        
        UserDefaults.standard.set(name, forKey: "nameUser")
        NotificationCenter.default.post(name: NSNotification.Name("nameUser"), object: nil)
        
        UserDefaults.standard.set(email, forKey: "emailUser")
        NotificationCenter.default.post(name: NSNotification.Name("emailUser"), object: nil)
}

