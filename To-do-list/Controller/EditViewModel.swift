//
//  EditViewModel.swift
//  To-do-list
//
//  Created by ineta.magone on 14/03/2022.
//

import UIKit

class EditViewModel: BaseViewModelProtocol {
    var onSetTitle: ((String) -> Void)?
    var onSetTaskText: ((String, String) -> Void)?
    var onReturn: ((String, String) -> Void)?
    
    private let taskManager = TaskManager.shared
    var task: TaskManager.Task?
    
    private var title: String = ""
    private var taskTitle: String = ""
    private var taskDescription: String = ""
    private var index: Int = 0
    
    
    func launch() {
        onSetTitle?(title)
        onSetTaskText?(taskTitle, taskDescription)
    }
    
    func saveTask(title: String, description: String) {
        addTasks(title: title, description: description)
    }
    
    func addTasks(title: String, description: String) {
        taskManager.tasks.append(TaskManager.Task(title: title, description: description, completed: false))
    }
    
    func deleteTaskManagerTasks() {
        taskManager.tasks = []
    }
    
    func getTask(at index: Int) {
        self.index = index
        task = taskManager.get(at: index)
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func setTaskStrings(taskTitle: String, taskDescription: String) {
        self.taskTitle = taskTitle
        self.taskDescription = taskDescription
    }

    func editTask(title: String?, description: String?) {
        let task = TaskManager.Task(title: title, description: description)
        taskManager.edit(task: task, at: self.index)
    }
    
}
