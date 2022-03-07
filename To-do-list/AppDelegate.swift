//
//  AppDelegate.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let controller = ViewController()
        let mainViewModel = MainViewModel()
        
        let taskController = TaskViewController()
        let taskViewModel = TaskViewModel()
        
        let navigationController = UINavigationController(rootViewController: controller)
        mainViewModel.onOpenTaskViewController = { [ weak self ] in
            navigationController.pushViewController(taskController.self, animated: true)
        }
        controller.configure(mainViewModel: mainViewModel)
        
        taskViewModel.onRefresh = { [ weak self ] in
            mainViewModel.refresh()
            taskController.present(controller, animated: true, completion: nil)
        }
        taskController.configure(taskViewModel: taskViewModel)
        
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


}

