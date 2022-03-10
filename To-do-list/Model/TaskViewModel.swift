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
    
    func deleteTaskManagerTasks() {
        taskManager.tasks.removeAll()
    }
    
    func setupTextFieldAppearence(titleField: UITextField, descriptionField: UITextView) {
        titleField.text = ""
        titleField.placeholder = "Task title"
        titleField.becomeFirstResponder()
        descriptionField.text = "description..."
        descriptionField.textColor = UIColor.lightGray
    }
}
