//
//  ViewController.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel: ViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        setNavBar()
    }
    
    func reloadTableView() {
        self.tableView?.reloadData()
    }
    
    func configure(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    @objc func addTask() {
        viewModel?.shouldOpenTaskViewController()
    }
    
    @objc func deleteTasks() {
        if viewModel?.taskCount() != 0 {
            deleteAlertMessage()
        } else {
            reloadTableView()
        }
    }
    
    func setNavBar() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.secondarySystemBackground
        self.navigationItem.title = "To Do List"
        let plusItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTask))
        plusItem.tintColor = .systemIndigo
        self.navigationItem.rightBarButtonItem = plusItem
        let trashItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(deleteTasks))
        trashItem.tintColor = .systemIndigo
        self.navigationItem.leftBarButtonItem = trashItem
    }
    
    func deleteAlertMessage() {
        let alertController = UIAlertController(title: "Delete All tasks?", message: "Do you want to delete them all?", preferredStyle: .actionSheet)
        let addActionButton = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.viewModel?.deleteAllTasks()
            self.reloadTableView()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addActionButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.taskCount() == 0 {
            setEmptyView()
        } else if viewModel?.taskCount() ?? 0 > 0 {
            restoreView()
        }
        return viewModel?.taskCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else { return .init() }
        
        let task = viewModel?.getTask(index: indexPath.row)
        
        cell.titleLabel.text = task?.title
        cell.descriptionLabel.text = task?.description
        
        // Checkmarks
        //cell.accessoryType = viewModel?.checkBool(index: indexPath.row) ?? false ? .checkmark : .none
        
        return cell
    }
    
    // Message appears when there are no tasks
    func setEmptyView() {
        let emptyView = UIView(frame: CGRect(x: tableView?.center.x ?? 0, y: tableView?.center.y ?? 0, width: tableView?.bounds.size.width ?? 0, height: tableView?.bounds.size.height ?? 0))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -150),
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20),
        ])
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "Helvetica Neue Bold", size: 18)
        titleLabel.text = "You don't have any tasks"
        messageLabel.textColor = UIColor.gray
        messageLabel.font = UIFont(name: "Helvetica Neue", size: 17)
        messageLabel.text = "You can add tasks by pressing on the +  button"
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.tableView.backgroundView = emptyView
    }
    
    func restoreView() {
        tableView.backgroundView = nil
    }
}

extension ViewController: UITableViewDelegate {
    
    // Deleting only one task by swiping
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel?.removeRow(index: indexPath.row)
            self.tableView?.deleteRows(at: [indexPath], with: .automatic)
        }
        reloadTableView()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = viewModel?.getTask(index: indexPath.row)
        let title = task?.title ?? ""
        let description = task?.description ?? ""
        viewModel?.getTaskStrings(title: title, description: description)
        viewModel?.editTask(at: indexPath)
        viewModel?.openEditViewController()
    }
}

