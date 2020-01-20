//
//  AppDelegate.swift
//  PADC9-mmChores-iOS
//
//  Created by Zaw Htet Naing on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        IQKeyboardManager.shared.enable = true
        //IQKeyboardManager.shared.enableDebugging = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true 
        IQKeyboardManager.shared.placeholderFont = UIFont(name: "Times New Roman", size: 15.0)
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        //IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
       // ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        print("Id", UserDefaults.standard.string(forKey: USERDEFAULT_ID_KEY))
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

}

