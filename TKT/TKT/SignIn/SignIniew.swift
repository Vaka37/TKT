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
    @State var message = ""
    @State var alert = false
    @State var show = false
    @State private var angle: Double = 0.0
    @State var colors: [Color] = [.red, .blue, .green, .purple]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            Text("Вход")
                .fontWeight(.heavy).font(.largeTitle)
                .padding()
            VStack(alignment: .leading){
                Text("e-mail")
                TextField("Введите ваш e-mail", text: $settingUser.loginTextField).textFieldStyle(.roundedBorder).keyboardType(.emailAddress)
                Text("Пароль")
                TextField("Введите ваш пароль", text: $settingUser.passwordTextField).textFieldStyle(.roundedBorder)
            }.padding()
            Button {
                signInWithEmail(email: self.settingUser.loginTextField, password: self.settingUser.passwordTextField) { verified, status in
                    if !verified {
                        self.message = status
                        self.alert.toggle()
                    }else{
                        createSaveUserDefaultAccaunt(name: settingUser.nameUser, email: settingUser.loginTextField)
                        let modelUser = ModelUser(nameUser: settingUser.nameUser, emailUser: settingUser.loginTextField, passwordUser: settingUser.passwordTextField)
                        dataManager.fetchUserDataOrder(modelUser: modelUser)
                        timer.upstream.connect().cancel()
                    }
                }
            } label: {
                GeometryReader(content: { geometry in
                    ZStack {
                        AngularGradient(gradient: Gradient(colors: colors),
                                        center: .center,
                                        angle: .degrees(angle))
                        .blendMode(.overlay)
                        .blur(radius: 6)
                        .mask(
                            RoundedRectangle(cornerRadius: 16)
                                .frame(maxWidth: geometry.size.width - 16)
                                .frame(height: 50)
                                .blur(radius: 6)
                        )
                        .onAppear() {
                            withAnimation(Animation.linear(duration: 7)
                                .repeatForever(autoreverses: false)) {
                                    angle += 360
                                }
                        }
                        .onReceive(timer) { input in
                            withAnimation {
                                colors.swapAt(0, 1)
                                colors.swapAt(1, 2)
                                colors.swapAt(2, 3)
                            }
                        }
                        Text("Войти")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color.black)
                            .frame(height: 50)
                            .frame(maxWidth: geometry.size.width - 16)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white, lineWidth: 1)
                                    .opacity(0.9)
                            )
                            .cornerRadius(16)
                    }
                })
            }.alert(isPresented: $alert) {
                Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("OK")))
            }
            Spacer().frame(height: 50)
            HStack{
                Text("Нет Аккаунта? ->")
                Button {
                    show.toggle()
                } label: {
                    Text("Присоединиться")
                }
            }.sheet(isPresented: $show) {
                SignUp(show: self.show)
            }
        }.onTapGesture {
            hideKeyboard()
        }
    }
}

struct SignUp: View{
    @StateObject var settingUser = SettingsUser.shared
    @EnvironmentObject var dataManager : DataManager
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
        }
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

