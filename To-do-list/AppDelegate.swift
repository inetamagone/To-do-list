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
            let baseController = self.createBaseViewController()
            let taskController = self.createTaskViewController(controller: controller)
            baseController.showSubViewController(viewController: taskController)
            self.navigationController?.pushViewController(baseController, animated: true)
        }
        
        viewModel.onOpenEditViewController = { [ weak self ] in
            guard let self = self else { return }
            let editController = self.createEditViewController()
            self.navigationController?.pushViewController(editController, animated: true)
        }
        controller.configure(viewModel: viewModel)
        return controller
    }
    
    func createBaseViewController() -> BaseViewController {
        guard let baseController = storyboard.instantiateViewController(withIdentifier: "BaseViewController") as? BaseViewController else { return .init() }
        
        //let baseModel = BaseViewModel()
        //let taskController = TaskViewController()
        //baseController.showSubViewController(viewController: taskController)
        baseController.configure(baseModel: baseModel)
        return baseController
    }
    
    func createTaskViewController(controller: ViewController) -> UIViewController {
//        let baseController = self.createBaseViewController()
        let taskController = TaskViewController()
        
        baseModel.onReturn = { [ weak self ] in
            controller.reloadTableView()
            self?.navigationController?.popViewController(animated: true)
        }
        return taskController
    }
    
    func createEditViewController() -> UIViewController {
        let baseController = self.createBaseViewController()
        let editController = EditViewController()
        return editController
    }
}

//    func createTaskViewController(controller: ViewController) -> TaskViewController {
//        guard let taskController = storyboard.instantiateViewController(withIdentifier: "TaskViewController") as? TaskViewController else { return .init() }
//        let taskModel = TaskViewModel()
//
//        taskModel.onReturn = { [ weak self ] in
//            controller.reloadTableView()
//            self?.navigationController?.popViewController(animated: true)
//        }
//        taskController.configure(taskModel: taskModel)
//        return taskController
//    }

