//
//  ViewModel.swift
//  To-do-list
//
//  Created by ineta.magone on 07/03/2022.
//

import UIKit

class ViewModel {
    
    private let taskManager = TaskManager.shared
    var taskTitle: String = ""
    var taskDescription: String = ""
    var onOpenTaskViewController: (() -> Void)?
    var onOpenEditViewController: (() -> Void)?
    var onEditTask: ((Int) -> Void)?
    
    func shouldOpenTaskViewController() {
        self.onOpenTaskViewController?()
    }
    
    func openEditViewController() {
        self.onOpenEditViewController?()
    }
    
    func getTask(index: Int) -> TaskManager.Task? {
        return taskManager.tasks[index]
    }
    
    func deleteAllTasks() {
        taskManager.tasks = []
    }
    
    func taskCount() -> Int {
        return taskManager.tasks.count
    }
    
    func removeRow(index: Int) -> TaskManager.Task {
        return (taskManager.tasks.remove(at: index))
    }
    
    func editTask(at indexPath: IndexPath) {
        onEditTask?(indexPath.row)
    }
    
    func getTaskStrings(title: String, description: String) {
        self.taskTitle = title
        self.taskDescription = description
    }
}
