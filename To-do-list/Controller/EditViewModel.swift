//
//  EditViewModel.swift
//  To-do-list
//
//  Created by ineta.magone on 14/03/2022.
//

import UIKit

class EditViewModel: BaseViewModelProtocol {
    var onSetTitle: ((String) -> Void)?
    
    private let taskManager = TaskManager.shared
    var onReturn: (() -> Void)?
    private var title: String = ""
    
    func launch() {
        onSetTitle?(title)
    }
    
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
    
    func setTitle(title: String) {
        self.title = title
    }
    
}
