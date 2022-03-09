//
//  TaskViewModel.swift
//  To-do-list
//
//  Created by ineta.magone on 07/03/2022.
//

import UIKit

class TaskViewModel {
    
    let taskManager = TaskManager()
    
    var onReturn: (() -> Void)?
    func returnToMainViewController() {
        self.onReturn?()
    }
    
    func saveTask(title: String, description: String) {
        taskManager.tasks.append(TaskManager.Task(title: title, description: description, completed: false))
    }
    
}
