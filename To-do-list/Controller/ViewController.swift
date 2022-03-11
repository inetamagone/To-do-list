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
        deleteAlertMessage()
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
        if viewModel?.taskCount() != 0 {
            let alertController = UIAlertController(title: "Delete All tasks?", message: "Do you want to delete them all?", preferredStyle: .actionSheet)
            viewModel?.setupAlertMessage(alertController: alertController)
            present(alertController, animated: true, completion: nil)
        } else {
            self.reloadTableView()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.taskCount() == 0 {
            setEmptyView()
        } else if viewModel?.taskCount() ?? 0 > 0 {
            viewModel?.restoreView(tableView: tableView)
        }
        return viewModel?.taskCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else { return .init() }
        
        let task = viewModel?.getTask(index: indexPath.row)
        
        cell.titleLabel.text = task?.title
        cell.descriptionLabel.text = task?.description
        
        // Checkmarks
        cell.accessoryType = viewModel?.checkBool(index: indexPath.row) ?? false ? .checkmark : .none
        
        return cell
    }
    
    // Message appears when there are no tasks
    func setEmptyView() {
        let emptyView = UIView(frame: CGRect(x: tableView?.center.x ?? 0, y: tableView?.center.y ?? 0, width: tableView?.bounds.size.width ?? 0, height: tableView?.bounds.size.height ?? 0))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        viewModel?.setEmptyViewAppearence(emptyView: emptyView, titleLabel: titleLabel, messageLabel: messageLabel)
        self.tableView.backgroundView = emptyView
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
    
    // Checkmarks
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.boolChange(index: indexPath.row)
        reloadTableView()
    }
}

