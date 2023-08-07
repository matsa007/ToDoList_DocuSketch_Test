//
//  TaskEditingViewController.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 6.08.23.
//

import UIKit

final class TaskEditingViewController: TaskAddingViewController {
    
    // MARK: - Parameters
    
    private var task: TaskModel
    var completion: ((TaskModel) -> ())?
    var closureVoid: (() -> ())?
    
    // MARK: - Initialization
        
    init(task: TaskModel) {
        self.task = task
        
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set view
    
    override func setTextFields() {
        self.titleTextField.text = self.task.taskTitle
        self.decriptionTextField.text = self.task.taskDescription
        
        super.setTextFields()
    }
    
    override func setNavigationBar() {
        self.navigationItem.title = NavigationTitles.editing.rawValue
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .done,
                                                                   target: self,
                                                                   action: #selector(self.doneButtonTapped)),
                                                   UIBarButtonItem(barButtonSystemItem: .trash,
                                                                   target: self,
                                                                   action: #selector(self.deleteButtontapped))]
    }
}

// MARK: - IBActions

extension TaskEditingViewController {
    override func doneButtonTapped() {
        guard let title = self.titleTextField.text else { return }
        self.task = TaskModel(taskTitle: title, taskDescription: self.decriptionTextField.text, priorityLevel: self.priorityLevel)
        self.completion?(self.task)
        
        super.doneButtonTapped()
    }
    
    @objc private func deleteButtontapped() {
        self.deletingAlertMessage(AlertMessages.deleting.rawValue, self.closeVc)
    }
    
    private func closeVc(_: UIAlertAction) {
        self.navigationController?.popViewController(animated: false)
        self.closureVoid?()
    }
}
