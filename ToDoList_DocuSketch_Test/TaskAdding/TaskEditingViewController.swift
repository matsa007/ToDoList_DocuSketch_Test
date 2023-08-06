//
//  TaskEditingViewController.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 6.08.23.
//

import UIKit

class TaskEditingViewController: TaskAddingViewController {
    
    private let task: TaskModel
    var completion: ((TaskModel) -> ())?
    
    // MARK: - Initialization
        
    init(task: TaskModel) {
        self.task = task
        
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .green
        self.titleTextField.text = self.task.taskTitle
        self.decriptionTextField.text = self.task.taskDescription
    }
}
