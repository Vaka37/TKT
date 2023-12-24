//
//  TKTApp.swift
//  TKT
//
//  Created by Kalandarov Vakil on 24.12.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore

@main

struct TKTApp: App {
    @StateObject var dataModel = DataManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataModel)
                .preferredColorScheme(.light)
        }
    }
}
