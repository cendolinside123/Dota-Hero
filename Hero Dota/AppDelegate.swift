//
//  AppDelegate.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 10/03/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    lazy var coreData = CoreDataStack(modelName: "Hero_Dota")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        let newsVC = HomeViewController()
        newsVC.setupCoreDataContext(coreData: coreData)
        let nav = UINavigationController(rootViewController: newsVC)
        nav.navigationBar.barTintColor = .white
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }

}

