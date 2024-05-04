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

///https://www.figma.com/file/AHuTKT8211L0ckisGDDLFa/Trucker-Application-(Community)?type=design&node-id=0-1&mode=design&t=wsROcYD8NXfkTn4o-0
struct TKTApp: App {
    @StateObject var dataModel = DataManager.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataModel)
                .preferredColorScheme(.light)
        }
    }
}
