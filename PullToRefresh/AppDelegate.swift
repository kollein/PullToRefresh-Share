//
//  AppDelegate.swift
//  PullToRefresh
//
//  Created by Vinh on 30/06/2024.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Open App")
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("Close App")
    }
}
