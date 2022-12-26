//
//  ContentView.swift
//  TKT
//
//  Created by Kalandarov Vakil on 24.12.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct SignIniew: View {
    @State var loginTextField: String = ""
    @State var passwordTextField: String = ""
    @State var message = ""
    @State var alert = false
    @State var show = false
    
    var body: some View {
        VStack{
        Text("Sign In")
                .fontWeight(.heavy).font(.largeTitle)
            .padding()
            VStack(alignment: .leading){
                Text("Username")
                TextField("Enter Your Username", text: $loginTextField).textFieldStyle(.roundedBorder)
                Text("Password")
                TextField("Enter Your Password", text: $passwordTextField).textFieldStyle(.roundedBorder)
            }
            Spacer().frame(height: 50)
            Button {
                signInWithEmail(email: self.loginTextField, password: self.passwordTextField) { verified, status in
                    if !verified {
                        self.message = status
                        self.alert.toggle()
                    }else{
                        UserDefaults.standard.set(true,forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                    }
                }
            } label: {
                Text("Sign in")
            }.alert(isPresented: $alert) {
                Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("OK")))
            }
            .foregroundColor(.white)
            .buttonStyle(.bordered)
            .frame(width: 130, height: 90)
            .background(Color.green)
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
        }
    }
}

struct SignUp:View{
    @State var loginTextField: String = ""
    @State var passwordTextField: String = ""
    @State var message = ""
    @State var alert = false
    @State var show = false
    
    var body: some View {
        VStack{
        Text("Sign Up")
                .fontWeight(.heavy).font(.largeTitle)
            .padding()
            VStack(alignment: .leading){
                Text("Username")
                TextField("Enter Your Username", text: $loginTextField).textFieldStyle(.roundedBorder)
                Text("Password")
                TextField("Enter Your Password", text: $passwordTextField).textFieldStyle(.roundedBorder)
            }
            Spacer().frame(height: 50)
            Button {
                signUpWithEmail(email: self.loginTextField, password: self.passwordTextField) { verified, status in
                    if !verified {
                        self.message = status
                        self.alert.toggle()
                    }else{
                        UserDefaults.standard.set(true, forKey: "status")
                                               self.show.toggle()
                                               NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                    }
                }
            } label: {
                Text("Sign Up")
            }.alert(isPresented: $alert) {
                Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("OK")))
            }
            .foregroundColor(.white)
            .buttonStyle(.bordered)
            .frame(width: 130, height: 90)
            .background(Color.green)
            Spacer().frame(height: 50)
    
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
