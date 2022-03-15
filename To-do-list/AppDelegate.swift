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
            let taskController = self.createTaskViewController(controller: controller)
            self.navigationController?.pushViewController(taskController, animated: true)
        }
        
        viewModel.onOpenEditViewController = { [ weak self ] in
            guard let self = self else { return }
            let editController = self.createEditViewController(controller: controller)
            self.navigationController?.pushViewController(editController, animated: true)
        }
        controller.configure(viewModel: viewModel)
        return controller
    }
    
    func createBaseViewController() -> BaseViewController {
        guard let baseController = storyboard.instantiateViewController(withIdentifier: "BaseViewController") as? BaseViewController else { return .init() }
        return baseController
    }
    
    func createTaskViewController(controller: ViewController) -> UIViewController {
        let taskController = createBaseViewController()
        let taskModel = TaskViewModel()
        taskModel.onReturn = { [ weak self ] in
            controller.reloadTableView()
            self?.navigationController?.popViewController(animated: true)
        }
        taskController.configure(baseModel: taskModel)
        taskModel.setTitle(title: "Task Controller")
        return taskController
    }
    
    func createEditViewController(controller: ViewController) -> UIViewController {
        let editController = createBaseViewController()
        let editModel = EditViewModel()
        editModel.onReturn = { [ weak self ] in
            controller.reloadTableView()
            self?.navigationController?.popViewController(animated: true)
        }
        editController.configure(baseModel: editModel)
        editModel.setTitle(title: "Edit Controller")
        return editController
    }
}

