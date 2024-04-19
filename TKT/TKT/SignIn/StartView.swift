//
//  StartView.swift
//  TKT
//
//  Created by Kalandarov Vakil on 27.12.2023.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image(uiImage: UIImage(named: "startView") ?? UIImage())
                    .resizable()
                    .scaledToFill()
                VStack{
                    NavigationLink {
                        SignIniew()
                    } label: {
                        Text("Вход")
                            .padding()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }.frame(width: 360).background(Color.black).cornerRadius(10)
                    NavigationLink {
                        SignUp()
                    } label: {
                        Text("Регистрация")
                            .padding()
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }.frame(width: 360).background(Color.clear).border(.black.opacity(0.3), width: 1).cornerRadius(10)
                    Spacer().frame(height: 100)
                }
            }
        }
    }
}
