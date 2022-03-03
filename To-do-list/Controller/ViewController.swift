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
        tableView.rowHeight = 60
    }
    
    @IBAction func addTask(_ sender: Any) {
        openTaskEdition()
    }
    
    @IBAction func deleteTask(_ sender: Any) {
    }
    
    func openTaskEdition() {
        guard let taskViewController = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as? TaskViewController else { return }
        taskViewController.completionHandler = { [weak self ] in
            self?.refresh()
        }
        navigationController?.pushViewController(taskViewController.self, animated: true)
    }
    func refresh() {
        tableView.reloadData()
        print(taskManager.tasks)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if !taskManager.tasks.isEmpty {
            count = taskManager.tasks.count
        } else {
            count = 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else {return .init()}
        cell.titleLabel.text = taskManager.tasks[indexPath.row].title
        cell.descriptionLabel.text = taskManager.tasks[indexPath.row].description
        return cell
    }
}

