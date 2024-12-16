//
//  AppDelegate.swift
//  YCiOSHelper
//
//  Created by 杨充 on 2024/11/27.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    
    //默认为AppDelegate，在app受到干扰时，会产生一些系统事件，这时UIApplication会通知它的delegate对象，让delegate代理来处理这些系统事件。
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //当应用程序启动完毕的时候就会调用(系统自动调用)
        print("iosLog application 当应用程序启动完毕的时候就会调用(系统自动调用)");
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
    
    func applicationWillResignActive(_ application: UIApplication) {
        //即将失去活动状态的时候调用(失去焦点, 不可交互)
        print("iosLog applicationWillResignActive 即将失去活动状态的时候调用");
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //应用程序进入后台的时候调用, 一般在该方法中保存应用程序的数据, 以及状态
        print("iosLog applicationDidEnterBackground 应用程序进入后台的时候调用");
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        //应用程序即将进入前台的时候调用, 一般在该方法中恢复应用程序的数据,以及状态
        print("iosLog applicationWillEnterForeground 应用程序即将进入前台的时候调用");
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        //重新获取焦点(能够和用户交互)
        print("iosLog applicationDidBecomeActive 重新获取焦点");
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        //应用程序即将被销毁的时候会调用该方法, 注意:如果应用程序处于挂起状态的时候无法调用该方法
        print("iosLog applicationWillTerminate 应用程序即将被销毁的时候会调用该方法");
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        //名字和Model.xcdatamodeld一样
        let container = NSPersistentContainer(name: "Model")
        //本地持久化资源的加载
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                //处理异常
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        //获取上下文
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

