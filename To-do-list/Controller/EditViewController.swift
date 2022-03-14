//
//  EditViewController.swift
//  To-do-list
//
//  Created by ineta.magone on 11/03/2022.
//

import UIKit

class EditViewController: UIViewController {

    private var editViewModel: EditViewModel?
    
    func configure(editModel: EditViewModel) {
        self.editViewModel = editModel
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .red
    }
    
    
}
