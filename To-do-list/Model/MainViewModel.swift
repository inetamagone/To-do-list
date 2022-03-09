//
//  MainView.swift
//  To-do-list
//
//  Created by ineta.magone on 07/03/2022.
//

import UIKit

class MainViewModel {
    
    var tasks: [TaskManager.Task] = []
    
    var onOpenTaskViewController: (() -> Void)?
    func shouldOpenTaskViewController() {
        self.onOpenTaskViewController?()
    }
    
    func addTask() {
        
    }
    
    func getTask(index: Int) -> TaskManager.Task {
        return tasks[index]
    }
    
    func deleteAllTasks() {
        if tasks.count != 0 {
            tasks.removeAll()
        } else {
            return
        }
    }
}
