//
//  TaskViewModel.swift
//  To-do-list
//
//  Created by ineta.magone on 15/03/2022.
//

import Foundation

final class TaskViewModel: BaseViewModelProtocol {
    
    private let taskManager = TaskManager.shared
    var task: TaskManager.Task?
    var onReturn: ((String, String) -> Void)?
    var onSetTitle: ((String) -> Void)?
    var onSetTaskText: ((String, String) -> Void)?
    private var title: String = ""
    private var taskTitle: String = ""
    private var taskDescription: String = ""
    private var index: Int = 0
    
    func launch() {
        onSetTitle?(title)
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
