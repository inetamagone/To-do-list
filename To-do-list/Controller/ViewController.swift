//
//  ViewController.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var mainViewModel: MainViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        setNavBar()
    }
    
    func reloadTableView() {
        self.tableView?.reloadData()
    }
    
    func configure(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    @objc func addTask() {
        mainViewModel?.shouldOpenTaskViewController()
    }
    
    @objc func deleteTasks() {
        mainViewModel?.deleteAllTasks()
        reloadTableView()
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
        return mainViewModel?.taskData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else {return .init()}
        cell.titleLabel.text = mainViewModel?.getTask(index: indexPath.row)?.title
        cell.descriptionLabel.text = mainViewModel?.getTask(index: indexPath.row)?.description
        
        return cell
    }
}

