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
    
    var onReloadTableView: (() -> Void)?
    func shouldReloadTableView() {
        self.onReloadTableView?()
    }
    
    func refresh() {
        let taskDictionnary = UserDefaults.standard.object(forKey: "newTask") as? [String: String] ?? [String: String]()
        guard let titleString = taskDictionnary["title"] else { return }
        guard let descriptionString = taskDictionnary["description"] else { return }
        taskManager.addOneTask(title: titleString, description: descriptionString)
        shouldReloadTableView()
    }
}
