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
    
    var taskTitle: String = ""
    var taskDescription: String = ""
    var indexPathRow: Int = 0
    
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
            // taskTitle, taskDescription and indexPathRow got before creation of editController
            self.taskTitle = viewModel.taskTitle
            self.taskDescription = viewModel.taskDescription
            self.indexPathRow = viewModel.index
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
        taskModel.onReturn = { [ weak self ] titleString, descriptionString in
            taskModel.saveTask(title: titleString, description: descriptionString)
            controller.reloadTableView()
            self?.navigationController?.popViewController(animated: true)
        }
        taskController.configure(baseModel: taskModel)
        taskModel.setTitle(title: "Add a Task")
        return taskController
    }
    
    func createEditViewController(controller: ViewController) -> UIViewController {
        let editController = createBaseViewController()
        let editModel = EditViewModel()
        editModel.onReturn = { [ weak self ] titleString, descriptionString in
            editModel.getTask(at: self?.indexPathRow ?? 0)
            editModel.editTask(title: titleString, description: descriptionString)
            controller.reloadTableView()
            self?.navigationController?.popViewController(animated: true)
        }
        editController.configure(baseModel: editModel)
        editModel.setTitle(title: "Edit Task")
        editModel.setTaskStrings(taskTitle: taskTitle, taskDescription: taskDescription)
        return editController
    }
    
}

