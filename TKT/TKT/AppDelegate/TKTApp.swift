//
//  TKTApp.swift
//  TKT
//
//  Created by Kalandarov Vakil on 24.12.2022.
//

import SwiftUI
import FirebaseCoreDiagnostics
import FirebaseAuth
import FirebaseCore

@main

struct TKTApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
