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
            let taskController = self.createTaskViewController(controller: controller)
            let taskModel = self.configureTaskModel(taskController: taskController as! TaskViewController)
            let editController = self.createEditViewController()
            
            taskModel.showEditViewController(taskController: taskController, editController: editController)
            
            self.navigationController?.pushViewController(taskController, animated: true)
        }
        controller.configure(viewModel: viewModel)

        return controller
    }

    func createTaskViewController(controller: ViewController) -> UIViewController {
        guard let taskController = storyboard.instantiateViewController(withIdentifier: "TaskViewController") as? TaskViewController else { return .init() }
        
        let taskModel = self.configureTaskModel(taskController: taskController)
        taskModel.onReturn = { [ weak self ] in
            controller.reloadTableView()
            self?.navigationController?.popViewController(animated: true)
        }
        return taskController
    }
    
    func configureTaskModel(taskController: TaskViewController) -> TaskViewModel {
        let taskModel = TaskViewModel()
        taskController.configure(taskModel: taskModel)
        return taskModel
    }
    
    func createEditViewController() -> UIViewController {
        let editController = EditViewController()
        let editModel = EditViewModel()
        editController.configure(editModel: editModel)
        return editController
    }
}



