//
//  AppDelegate.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/06/05.
//

import UIKit
import CoreData
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: 메모 데이터 list 정의
    var memoList = [MemoData]()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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
    
    /**
        Add Core Data : )
     */
    func applicationWillTerminate(_ application: UIApplication)
    {
        self.saveContext()
    }
    lazy var persistentContainer : NSPersistentContainer =
    {
        let container = NSPersistentContainer(name:"DataModel")
        container.loadPersistentStores
        {
            if let error = $1 as NSError?
            {
                fatalError("Unresolved err \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    func saveContext()
    {
        let context = persistentContainer.viewContext
        if context.hasChanges
        {
            do
            {
                try context.save()
            }
            catch let err as NSError
            {
                fatalError("Unresolved error \(err), \(err.userInfo)")
            }
        }
    }
}

