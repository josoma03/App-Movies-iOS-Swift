//
//  AppDelegate.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 18/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.initFiles()
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


    /**
     * Permite copiar los plist al bundle, e inicializar las variables del NSUserDefaults
     */
    func initFiles()
    {
        NSLog("Rappi - loadDataSettings")
        self.copyDatabaseIfNeeded()
    }
    
    func copyDatabaseIfNeeded() {
        let fileManager = FileManager.default
        guard let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let finalDatabaseURL = documentsUrl.appendingPathComponent("rappi.db")
        
        do {
            if !fileManager.fileExists(atPath: finalDatabaseURL.path) {
                print("Rappi - DB does not exist in documents folder")
                
                if let dbFilePath = Bundle.main.path(forResource: "rappi", ofType: "db") {
                    try fileManager.copyItem(atPath: dbFilePath, toPath: finalDatabaseURL.path)
                } else {
                    print("Rappi - is not in the app bundle")
                }
            } else {
                print("Rappi - Database file found at path: \(finalDatabaseURL.path)")
            }
        } catch {
            print("Rappi - Unable to copy: \(error)")
        }
    }
}

