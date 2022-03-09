//
//  TaskViewModel.swift
//  To-do-list
//
//  Created by ineta.magone on 07/03/2022.
//

import UIKit

class TaskViewModel {
    
    private let taskManager = TaskManager()
    
    var tasks: [TaskManager.Task] = []
    
    var onRefresh: (() -> Void)?
    
    func refreshMainViewController() {
        self.onRefresh?()
    }
    
    func saveTask(title: String, description: String) {
        tasks.append(TaskManager.Task(title: title, description: description, completed: false))
    }
    
}
