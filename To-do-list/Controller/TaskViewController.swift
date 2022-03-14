//
//  TaskViewController.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    private var taskViewModel: TaskViewModel?
    let editViewController = EditViewController()
    
    func configure(taskModel: TaskViewModel) {
        self.taskViewModel = taskModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewTitle.text = "Add a Task"
        self.titleField.delegate = self
        self.descriptionField.delegate = self
        titleField.placeholder = "Task title"
        titleField.becomeFirstResponder()
        descriptionField.text = "description..."
        descriptionField.textColor = UIColor.lightGray
    }
    
    internal func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionField.textColor == UIColor.lightGray {
            descriptionField.text = nil
            descriptionField.textColor = UIColor.black
        }
    }
    
    internal func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionField.text.isEmpty {
            descriptionField.text = "description..."
            descriptionField.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleField.text, !title.isEmpty else { return }
        guard let description = descriptionField.text, !description.isEmpty else { return }
        taskViewModel?.saveTask(title: title, description: description)
    }
    
//    func showEditViewController(taskViewController: UIViewController, editViewController: UIViewController) {
//        self.addChild(editViewController)
//        self.view.addSubview(editViewController.view)
//        self.didMove(toParent: self)
//        self.view.frame = self.view.bounds
//    }
    
}
