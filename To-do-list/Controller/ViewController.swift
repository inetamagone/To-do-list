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
        tableView?.dataSource = self
        tableView?.delegate = self
        setNavBar()
    }
    
    func configure(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    @objc func addTask() {
        mainViewModel?.shouldOpenTaskViewController()
    }
    
    @objc func deleteTasks() {
        deleteAllTasks()
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func deleteAllTasks() {
        if taskManager.tasks.count != 0 {
            let alertController = UIAlertController(title: "Delete All Tasks?", message: "Do you want to delete them all?", preferredStyle: .actionSheet)
            let addActionButton = UIAlertAction(title: "Delete", style: .destructive) { action in
                self.deleteAll()
            }
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(addActionButton)
            alertController.addAction(cancelButton)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            taskManager.reloadTableView(tableView: tableView)
        }
    }
    
    func deleteAll() {
        taskManager.tasks.removeAll()
        taskManager.reloadTableView(tableView: tableView)
    }
    
    func setNavBar() {
        self.navigationItem.title = "To Do List"
        let plusItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTask))
        plusItem.tintColor = .black
        self.navigationItem.rightBarButtonItem = plusItem
        let trashItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(deleteTasks))
        trashItem.tintColor = .black
        self.navigationItem.leftBarButtonItem = trashItem
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
