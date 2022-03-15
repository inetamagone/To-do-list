//
//  TaskViewModel.swift
//  To-do-list
//
//  Created by ineta.magone on 07/03/2022.
//

import UIKit

protocol BaseViewModelProtocol {
    
    var onReturn: (() -> Void)? { get set }
    var onSetTitle: ((String) -> Void)? { get set }
    
    func launch()
    func saveTask(title: String, description: String)
    func addTasks(title: String, description: String)
    func deleteTaskManagerTasks()
    func setTitle(title: String)
}
