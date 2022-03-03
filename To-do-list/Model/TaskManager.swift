//
//  TaskManager.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class TaskManager {
    
    // MARK: - Structure
    
    struct Task {
        var title: String
        var description: String
    }
    
    var tasks: [Task] = []

    // MARK: - Methods
    
    // ViewController
    func reloadTableView(tableView: UITableView) {
        tableView.reloadData()
    }
    
    // TaskViewController
    func addTask(title: String, description: String) {
        tasks.append(Task(title: title, description: description))
    }
    
}
