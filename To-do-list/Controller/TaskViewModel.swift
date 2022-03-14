//
//  TaskViewModel.swift
//  To-do-list
//
//  Created by ineta.magone on 07/03/2022.
//

import UIKit

class TaskViewModel {
    
    private let taskManager = TaskManager.shared
    
    var onReturn: (() -> Void)?
    
    func saveTask(title: String, description: String) {
        addTasks(title: title, description: description)
        onReturn?()
    }
    
    func addTasks(title: String, description: String) {
        taskManager.tasks.append(TaskManager.Task(title: title, description: description, completed: false))
    }
    
    func deleteTaskManagerTasks() {
        taskManager.tasks = []
    }
    // AppDelegate onOpenEditViewController
    func showEditViewController(taskController: UIViewController, editController: UIViewController) {
        taskController.addChild(editController)
        taskController.view.addSubview(editController.view)
        editController.didMove(toParent: taskController)
        editController.view.frame = taskController.view.bounds
    }
    
    
//    func setEditControllerTitle(taskController: UIViewController) {
//        taskController.viewTitle.text = "Edit Task"
//    }
    
}
