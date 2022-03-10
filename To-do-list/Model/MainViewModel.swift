//
//  MainView.swift
//  To-do-list
//
//  Created by ineta.magone on 07/03/2022.
//

import UIKit

class MainViewModel {
    
    let taskManager = TaskManager()
    var taskData: [TaskManager.Task]?
    
    var onOpenTaskViewController: (() -> Void)?
    func shouldOpenTaskViewController() {
        self.onOpenTaskViewController?()
    }
    
    var onDeleteAllTasks: (() -> Void)?
    func shouldDeleteTaskManagerTasks() {
        self.onDeleteAllTasks?()
    }
    
    // AppDelegate
    func addTask(taskData: [TaskManager.Task]) {
        self.taskData = taskData
    }
    
    func getTask(index: Int) -> TaskManager.Task? {
        return taskData?[index]
    }
    
    func deleteAllTasks() {
        if taskData?.count != 0 {
            taskData?.removeAll()
        } else {
            return
        }
    }
}
