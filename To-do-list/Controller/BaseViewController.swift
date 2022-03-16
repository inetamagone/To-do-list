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
    
    var baseViewModel: BaseViewModelProtocol?
    
    func configure(baseModel: BaseViewModelProtocol) {
        self.baseViewModel = baseModel
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [ weak self ] in
            self?.baseViewModel?.onSetTitle = { [ weak self ] titleText in
                self?.viewTitle?.text = titleText
            }
            self?.baseViewModel?.onSetTaskText = { [ weak self ] title, description in
                self?.titleField?.text = title
                self?.descriptionField?.text = description
            }
            self?.baseViewModel?.launch()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
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
        baseViewModel?.saveTask(title: title, description: description)
    }
    
}
                                      
private extension BaseViewController {
    func setupItems() {
        self.viewTitle?.text = "Base title"
        self.titleField?.delegate = self
        self.descriptionField?.delegate = self
        titleField?.placeholder = "Task title"
        titleField?.becomeFirstResponder()
        descriptionField?.text = "description..."
        descriptionField?.textColor = UIColor.lightGray
    }
}
