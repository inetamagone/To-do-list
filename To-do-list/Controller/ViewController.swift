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
    
    @IBAction func addTask(_ sender: Any) {
        openTaskEdition()
    }
    
    @IBAction func deleteTasks(_ sender: Any) {
        if taskManager.tasks.count != 0 {
            taskManager.tasks.removeAll()
            taskManager.reloadTableView(tableView: tableView)
        }
    }
    
    func openTaskEdition() {
        guard let taskViewController = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as? TaskViewController else { return }
        taskViewController.completionHandler = { [ weak self ] in
            self?.refresh()
        }
        navigationController?.pushViewController(taskViewController.self, animated: true)
    }
    
    func refresh() {
        taskManager.reloadTableView(tableView: tableView)
        print("ViewController: ", taskManager.tasks)
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
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    // Deleting only one task
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.delete(taskManager.tasks[indexPath.row])
        }
        taskManager.reloadTableView(tableView: self.tableView)
    }
}

