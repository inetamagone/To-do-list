//
//  ViewController.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
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
        present(taskViewController, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
}
