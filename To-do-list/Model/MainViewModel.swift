//
//  MainView.swift
//  To-do-list
//
//  Created by ineta.magone on 07/03/2022.
//

import UIKit

class MainViewModel {
    
    private let viewController = ViewController()
    private let taskManager = TaskManager()
    
    var tasks: [TaskManager.Task] = []
    
    var onOpenTaskViewController: (() -> Void)?
    func shouldOpenTaskViewController() {
        self.onOpenTaskViewController?()
    }
    
    func refresh() {
        let taskDictionnary = UserDefaults.standard.object(forKey: "newTask") as? [String: String] ?? [String: String]()
        guard let titleString = taskDictionnary["title"] else { return }
        guard let descriptionString = taskDictionnary["description"] else { return }
        addOneTask(title: titleString, description: descriptionString)
        viewController.reloadTableView()
    }
    
    func addOneTask(title: String, description: String) {
        tasks.append(TaskManager.Task(title: title, description: description, completed: false))
    }
    
    func getTask(index: Int) -> TaskManager.Task {
        return tasks[index]
    }
    
    func deleteAllTasks() {
        if tasks.count != 0 {
            tasks.removeAll()
            viewController.reloadTableView()
        } else {
            viewController.reloadTableView()
        }
    }
}
