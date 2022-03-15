//
//  TaskViewController.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class BaseViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    var baseViewModel: BaseViewModel?
    
    func configure(baseModel: BaseViewModel) {
        self.baseViewModel = baseModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewTitle?.text = "Base title"
        self.titleField?.delegate = self
        self.descriptionField?.delegate = self
        titleField?.placeholder = "Task title"
        titleField?.becomeFirstResponder()
        descriptionField?.text = "description..."
        descriptionField?.textColor = UIColor.lightGray
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
        print("tap")
        guard let title = titleField.text, !title.isEmpty else { return }
        guard let description = descriptionField.text, !description.isEmpty else { return }
        baseViewModel?.saveTask(title: title, description: description)
    }
    
    func showSubViewController(viewController: UIViewController) {
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        self.didMove(toParent: self)
        self.view.frame = self.view.bounds
        setViewTitle(title: "ADD A TASK")
    }
    
    func setViewTitle(title: String) {
        self.viewTitle?.text = title
    }
}

final class TaskViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewTitle?.text = "ADD TASK"
        let title = "Add a Task"
        setViewTitle(title: title)
        //self.view.backgroundColor = .red
        print("taskVC")
        print(viewTitle?.text ?? "empty")
    }
}

final class EditViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let title = "Edit Task"
        setViewTitle(title: title)
    }
}

    
    

