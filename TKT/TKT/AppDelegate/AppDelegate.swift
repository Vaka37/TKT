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
//import FirebaseMessaging
//import FirebaseAnalytics

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      window?.overrideUserInterfaceStyle = .light
    return true
  }
}

