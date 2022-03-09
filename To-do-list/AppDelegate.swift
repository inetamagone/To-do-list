//
//  AppDelegate.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return false }
        let mainViewModel = MainViewModel()
        
        guard let taskController = storyboard.instantiateViewController(withIdentifier: "TaskViewController") as? TaskViewController else { return false }
        let taskViewModel = TaskViewModel()
        
        let navigationController = UINavigationController(rootViewController: controller)
        mainViewModel.onOpenTaskViewController = { [ weak self ] in
            navigationController.pushViewController(taskController, animated: true)
        }
        controller.configure(mainViewModel: mainViewModel)
        
        taskViewModel.onReturn = { [ weak self ] in
            controller.reloadTableView()
            navigationController.popToRootViewController(animated: true)
        }
        taskController.configure(taskViewModel: taskViewModel)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}



