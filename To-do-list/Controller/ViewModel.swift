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
    var onOpenEditViewController: (() -> Void)?
    
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
}
