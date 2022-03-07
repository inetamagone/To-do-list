//
//  ViewController.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var mainViewModel: MainViewModel?
    private let taskManager = TaskManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configure(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    @IBAction func addTask(_ sender: Any) {
        mainViewModel?.shouldOpenTaskViewController()
    }
    
    @IBAction func deleteTasks(_ sender: Any) {
        mainViewModel?.deleteAllTasks()
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
    
    // Deleting only one task by swiping
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.taskManager.tasks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        taskManager.reloadTableView(tableView: self.tableView)
    }
    // Checkmarks
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        taskManager.tasks[indexPath.row].completed = !taskManager.tasks[indexPath.row].completed
        taskManager.reloadTableView(tableView: self.tableView)
    }
}
