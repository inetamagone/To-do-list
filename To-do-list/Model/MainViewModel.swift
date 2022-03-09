//
//  MainView.swift
//  To-do-list
//
//  Created by ineta.magone on 07/03/2022.
//

import UIKit

class MainViewModel {
    
    let taskManager = TaskManager()
    
    var onOpenTaskViewController: (() -> Void)?
    func shouldOpenTaskViewController() {
        self.onOpenTaskViewController?()
    }
    
    func addTask() {
        
    }
    
    func getTask(index: Int) -> TaskManager.Task {
        return taskManager.tasks[index]
    }
    
    func deleteAllTasks() {
        if taskManager.tasks.count != 0 {
            taskManager.tasks.removeAll()
            // Need to reloadTableView
        } else {
            return
        }
    }
}
