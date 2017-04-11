//
//  AppDelegate.swift
//  Razerr
//
//  Created by Lukasz on 22.01.2017.
//  Copyright © 2017 Lukasz. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 216.0/255.0, green: 74.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        
        if let barFont = UIFont(name: "Avenir-Light", size: 24.0) {
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName:barFont]
        }
        
        UITabBar.appearance().tintColor =  UIColor(red: 216.0/255.0, green: 74.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        UITabBar.appearance().backgroundColor = UIColor.black
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if accepted {
                print("Notification access success.")
            } else {
                print("User notifications i not allowed")
            }
        }
        
               
        
        
//        let getSessionToken = UserDefaults.standard.string(forKey: "sessionToken")
//        
//        if getSessionToken != nil {
//            
//            let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let controllerLogin : UIViewController = sb.instantiateViewController(withIdentifier: "newView") as! MainViewController
//            self.window?.rootViewController = controllerLogin
//        } else {
//            
//            let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let controllerLogin : UIViewController = sb.instantiateViewController(withIdentifier: "firstView") as! MasterViewController
//            self.window?.rootViewController = controllerLogin
//        }

        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

