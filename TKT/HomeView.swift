//
//  HomeView.swift
//  TKT
//
//  Created by Vakil on 05.05.2024.
//

import SwiftUI


/// Вью с грузовиками и элементами меню
struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Image("bacgroundImage")
                    .resizable()
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
            }
            .frame(width: 483, height: 322)
            bottomView
                .offset(y: -20)
        }
        .ignoresSafeArea()
    }
    
    
    private var bottomView: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                menuView
            }
        }
    }
    
    /// Меню Вью
    private var menuView: some View {
        HStack {
            Spacer()
            Button(action: {
                
            }, label: {
                makeCellMenu(iconMenu: "plusIcon", headerCell: "Найти работу")
            })
            Spacer()
            Button(action: {
                
            }, label: {
                makeCellMenu(iconMenu: "driver", headerCell: "Найти машину")
            })
            Spacer()
        }
    }
    
    
    /// Создание одной ячейки эелемента меню
    private func makeCellMenu(iconMenu: String, headerCell: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 176, height: 148)
                .border(.gray, width: 1)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            VStack {
                HStack {
                    ZStack {
                        Circle()
                            .fill(Color.purple.opacity(0.3))
                            .frame(width: 40)
                        Image(iconMenu)
                    }
                    Text(headerCell)
                        .foregroundColor(Color("textColor"))
                }
                Spacer()
                    .frame(height: 50)
            }
        }
    }
}

#Preview {
    HomeView()
}
