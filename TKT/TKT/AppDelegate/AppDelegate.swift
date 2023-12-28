//
//  AppDelegate.swift
//  TKT
//
//  Created by Kalandarov Vakil on 24.12.2022.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import YandexMapsMobile

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        YMKMapKit.setApiKey("a469959f-9649-4fd3-9f65-62d6df2549a8")
        YMKMapKit.sharedInstance()
        window?.overrideUserInterfaceStyle = .light
        return true
    }
}

