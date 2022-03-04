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
    
    // Will take refresh() function from ViewController to pass UserDefaults and reload table view before going back to root VC
    public var completionHandler: (() -> Void)?
    
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
        
        let taskDictionnary = ["title": title, "description": description]
        UserDefaults.standard.set(taskDictionnary, forKey: "newTask")
        
        completionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
    
}
