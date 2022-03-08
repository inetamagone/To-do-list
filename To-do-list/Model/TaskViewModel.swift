//
//  TaskViewModel.swift
//  To-do-list
//
//  Created by ineta.magone on 07/03/2022.
//

import UIKit

class TaskViewModel {
    
    private let taskManager = TaskManager()
    
    var onRefresh: (() -> Void)?
    
    func refreshMainViewController() {
        self.onRefresh?()
    }
    
    func userDefaultsRefresh(title: String, description: String) {
        let taskDictionnary = ["title": title, "description": description]
        UserDefaults.standard.set(taskDictionnary, forKey: "newTask")
        //refreshMainViewController()
    }
    
}
