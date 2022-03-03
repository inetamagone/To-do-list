//
//  TaskManager.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class TaskManager {
    
    // MARK: - Variables
    
    var titleArray = [String]()
    var descriptionArray = [String]()
 
    // MARK: - Methods
    
    // ViewController
    func reloadTableView(tableView: UITableView) {
        tableView.reloadData()
    }
    
    // TaskViewController
    func addTask(title: String, description: String) {
        titleArray.append(title)
        descriptionArray.append(description)
        print(titleArray, descriptionArray)
    }
    
}
