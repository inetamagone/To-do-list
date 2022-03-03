//
//  ViewController.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    public var completionHandler: (() -> Void)?
    
    private let taskManager = TaskManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleField.delegate = self
        self.descriptionField.delegate = self
        
        self.titleField.placeholder = "Task title"
        self.descriptionField.placeholder = "description..."
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleField.text, !title.isEmpty else { return }
        guard let description = descriptionField.text, !description.isEmpty else { return }
        taskManager.addTask(title: title, description: description)
        print(taskManager.tasks)
        completionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
    
}
