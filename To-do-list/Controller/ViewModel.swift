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
    var onDeleteAll: (() -> Void)?
    
    func shouldOpenTaskViewController() {
        self.onOpenTaskViewController?()
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
    
    func checkBool(index: Int) -> Bool {
        return taskManager.tasks[index].completed
    }
    
    func boolChange(index: Int) -> Bool {
        if taskManager.tasks[index].completed == false {
            taskManager.tasks[index].completed = true
        } else {
            taskManager.tasks[index].completed = false
        }
        return taskManager.tasks[index].completed
    }
    
    func setEmptyViewAppearence(emptyView: UIView, titleLabel: UILabel, messageLabel: UILabel) {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -100),
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20),
        ])
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "Helvetica Neue Bold", size: 18)
        titleLabel.text = "You don't have any tasks"
        messageLabel.textColor = UIColor.gray
        messageLabel.font = UIFont(name: "Helvetica Neue", size: 17)
        messageLabel.text = "You can add tasks by pressing on the +  button"
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
    }
    
    func restoreView(tableView: UITableView) {
        tableView.backgroundView = nil
    }
    
    func setupAlertMessage(alertController: UIAlertController) {
        let addActionButton = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteAllTasks()
            self.onDeleteAll?()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addActionButton)
        alertController.addAction(cancelButton)
    }
}
