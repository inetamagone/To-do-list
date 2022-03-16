//
//  TaskManager.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class TaskManager {
    
    struct Task {
        var title: String?
        var description: String?
        var completed: Bool?
    }
    
    var tasks: [Task] = []
    
    static var shared = TaskManager()

    private init() {}
    
    func save(task: Task) {
        tasks.append(task)
    }

    func get(at index: Int) -> Task? {
        guard index < tasks.count else { return nil }
        return tasks[index]
    }

    func tasksCount() -> Int {
        return tasks.count
    }

    func edit(task: Task, at index: Int) {
        guard index < tasks.count else { return }
        tasks[index] = task
    }
}
