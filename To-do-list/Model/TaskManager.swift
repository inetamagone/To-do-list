//
//  TaskManager.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class TaskManager {
    
    struct Task {
        var title: String
        var description: String
        var completed: Bool
    }
    
    var tasks: [Task] = []
    
    // Called in MainViewModel, refresh()
    func addOneTask(title: String, description: String) {
        tasks.append(Task(title: title, description: description, completed: false))
    }
    
    func reloadTableView(tableView: UITableView) {
        tableView.reloadData()
    }
    
}
