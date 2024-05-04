//
//  TabBarMainView.swift
//  TKT
//
//  Created by Vakil on 04.05.2024.
//

import SwiftUI

struct TabBarMainView: View {
    // MARK: - Constants
    
    private enum Constants {
        static let orderTitle = "Меню"
        static let homePageTitle = "Аккаунт"
    }
    var body: some View {
        TabView {
            HomeView()
                .tag("HomeView")
                .tabItem { Label(Constants.orderTitle, systemImage: "truck.box") }
            Account()
                .tag("Home")
                .tabItem { Label(Constants.homePageTitle, systemImage: "person") }
        }.accentColor(Color("tintColor"))
    }
}
