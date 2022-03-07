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
    
    var onOpenTaskViewController: (() -> Void)?

    func shouldOpenTaskViewController() {
        self.onOpenTaskViewController?()
    }
    
    func refresh() {
        let taskDictionnary = UserDefaults.standard.object(forKey: "newTask") as? [String: String] ?? [String: String]()
        guard let titleString = taskDictionnary["title"] else { return }
        guard let descriptionString = taskDictionnary["description"] else { return }
        taskManager.addOneTask(title: titleString, description: descriptionString)
        
        taskManager.reloadTableView(tableView: viewController.tableView)
    }
    
    func deleteAllTasks() {
        if taskManager.tasks.count != 0 {
            let alertController = UIAlertController(title: "Delete All Tasks?", message: "Do you want to delete them all?", preferredStyle: .actionSheet)
            let addActionButton = UIAlertAction(title: "Delete", style: .destructive) { action in
                self.deleteAll()
            }
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(addActionButton)
            alertController.addAction(cancelButton)
            
            viewController.present(alertController, animated: true, completion: nil)
        } else {
            taskManager.reloadTableView(tableView: viewController.tableView)
        }
    }
    
    func deleteAll() {
        taskManager.tasks.removeAll()
        taskManager.reloadTableView(tableView: viewController.tableView)
    }
}
