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
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    var navigationController: UINavigationController?
    var baseModel = BaseViewModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let controller = createViewContorller()
        navigationController = UINavigationController(rootViewController: controller)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func createViewContorller() -> UIViewController {
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return .init() }
        let viewModel = ViewModel()
        
        viewModel.onOpenTaskViewController = { [ weak self ] in
            guard let self = self else { return }
            let taskController = self.createTaskViewController()
            self.navigationController?.pushViewController(taskController, animated: true)
        }
        
        viewModel.onOpenEditViewController = { [ weak self ] in
            guard let self = self else { return }
            
            let editController = self.createEditViewController()
            self.navigationController?.pushViewController(editController, animated: true)
        }
        controller.configure(viewModel: viewModel)
        return controller
    }
    
    func createBaseViewController(controller: ViewController) -> UIViewController {
        guard let baseController = storyboard.instantiateViewController(withIdentifier: "BaseViewController") as? BaseViewController else { return .init() }
        let baseModel = BaseViewModel()
        
        baseModel.onReturn = { [ weak self ] in
            controller.reloadTableView()
            self?.navigationController?.popViewController(animated: true)
        }
        baseController.configure(baseModel: baseModel)
        return baseController
    }
    
    func createTaskViewController() -> UIViewController {
        let baseController = self.createBaseViewController(controller: ViewController())
        let taskController = TaskViewController()
        return taskController
    }
    
    func createEditViewController() -> UIViewController {
        let editController = EditViewController()
        let editModel = EditViewModel()
        editController.configure(baseModel: baseModel)
        return editController
    }
}

