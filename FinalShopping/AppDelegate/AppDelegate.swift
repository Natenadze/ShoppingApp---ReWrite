//
//  AppDelegate.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 06.05.23.
//

import UIKit
import CoreData
import Firebase


@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let navigation = UINavigationController(rootViewController: FirstPageVC())
        window?.rootViewController = navigation
        
        return true
    }

}

