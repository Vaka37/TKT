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


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
