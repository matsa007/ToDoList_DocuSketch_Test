//
//  TaskAddingViewController.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 5.08.23.
//

import UIKit

final class TaskAddingViewController: UIViewController {
    
    // MARK: - Parameters
    
    private var newTask: [TaskModel] = []
    var closure: ((TaskModel) -> ())?
    
    // MARK: - GUI
    
    private lazy var priorityStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var redPriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.redPriorityButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.tag = 1
        button.setImage(UIImage(named: "red_flag"), for: .normal)
        let highlightedImage = UIImage(named: "red_flag_highlighted")
            button.setImage(highlightedImage, for: .highlighted)
        return button
    }()
    
    private lazy var blackPriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.blackPriorityButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.tag = 1
        button.setImage(UIImage(named: "black_flag"), for: .normal)
        return button
    }()
    
    private lazy var bluePriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.bluePriorityButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.tag = 1
        button.setImage(UIImage(named: "blue_flag"), for: .normal)
        return button
    }()
    
    private lazy var greenPriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.greenPriorityButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.tag = 1
        button.setImage(UIImage(named: "green_flag"), for: .normal)
        return button
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type your task title here ..."
        textField.backgroundColor = .green
        return textField
        
    }()
    
    private lazy var decriptionTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .cyan
        textField.placeholder = "Type your task decription here ..."
        return textField
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        self.addSubviews()
        self.setConstraints()
    }
    
    // MARK: - Add subviews
    
    private func addSubviews() {
        
    }
    
    // MARK: - Set constraints
    
    private func setConstraints() {
        
    }
}

// MARK: - IBActions

extension TaskAddingViewController {
    @objc private func redPriorityButtonTapped() {
        print("redPriorityButtonTapped")
    }
    
    @objc private func blackPriorityButtonTapped() {
        print("blackPriorityButtonTapped")
    }
    
    @objc private func bluePriorityButtonTapped() {
        print("bluePriorityButtonTapped")
    }
    
    @objc private func greenPriorityButtonTapped() {
        print("greenPriorityButtonTapped")
    }
}
