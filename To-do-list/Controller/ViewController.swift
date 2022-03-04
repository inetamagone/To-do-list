//
//  ViewController.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let taskManager = TaskManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
    }
    
    func refresh() {
        let taskDictionnary = UserDefaults.standard.object(forKey: "newTask") as? [String: String] ?? [String: String]()
        guard let titleString = taskDictionnary["title"] else { return }
        guard let descriptionString = taskDictionnary["description"] else { return }
        taskManager.addTask(title: titleString, description: descriptionString)
        
        taskManager.reloadTableView(tableView: tableView)
    }
    
    func openTaskEdition() {
        guard let taskViewController = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as? TaskViewController else { return }
        
        taskViewController.completionHandler = {
            self.refresh()
        }
        navigationController?.pushViewController(taskViewController.self, animated: true)
    }
    
    @IBAction func addTask(_ sender: Any) {
        openTaskEdition()
    }
    
    @IBAction func deleteTasks(_ sender: Any) {
        if taskManager.tasks.count != 0 {
            taskManager.tasks.removeAll()
            taskManager.reloadTableView(tableView: tableView)
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskManager.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else {return .init()}
        cell.titleLabel.text = taskManager.tasks[indexPath.row].title
        cell.descriptionLabel.text = taskManager.tasks[indexPath.row].description
        
        // Checkmarks
        cell.accessoryType = taskManager.tasks[indexPath.row].completed ? .checkmark : .none
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    // Deleting only one task
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.taskManager.tasks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        taskManager.reloadTableView(tableView: self.tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        taskManager.tasks[indexPath.row].completed = !taskManager.tasks[indexPath.row].completed
        taskManager.reloadTableView(tableView: self.tableView)
    }
}

