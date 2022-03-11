//
//  ViewModel.swift
//  To-do-list
//
//  Created by ineta.magone on 07/03/2022.
//

import UIKit

class ViewModel {
    
    private let taskManager = TaskManager.shared
    var onOpenTaskViewController: (() -> Void)?
    
    func shouldOpenTaskViewController() {
        self.onOpenTaskViewController?()
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
    
    func checkBool(index: Int) -> Bool {
        return taskManager.tasks[index].completed
    }
    
    func boolChange(index: Int) -> Bool {
        if taskManager.tasks[index].completed == false {
            taskManager.tasks[index].completed = true
        } else {
            taskManager.tasks[index].completed = false
        }
        return taskManager.tasks[index].completed
    }
}
