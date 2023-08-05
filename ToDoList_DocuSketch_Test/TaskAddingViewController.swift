//
//  TaskAddingViewController.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 5.08.23.
//

import UIKit

final class TaskAddingViewController: UIViewController {
    
    // MARK: - Parameters
    
    private var newTask = TaskModel(taskTitle: "")
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
        button.backgroundColor = .red
        button.tag = 1
        button.setImage(UIImage(named: "red_flag"), for: .normal)
        let highlightedImage = UIImage(named: "red_flag_highlighted")
            button.setImage(highlightedImage, for: .highlighted)
        return button
    }()
    
    private lazy var blackPriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.blackPriorityButtonTapped), for: .touchUpInside)
        button.backgroundColor = .black
        button.tag = 1
        button.setImage(UIImage(named: "black_flag"), for: .normal)
        return button
    }()
    
    private lazy var bluePriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.bluePriorityButtonTapped), for: .touchUpInside)
        button.backgroundColor = .blue
        button.tag = 1
        button.setImage(UIImage(named: "blue_flag"), for: .normal)
        return button
    }()
    
    private lazy var greenPriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.greenPriorityButtonTapped), for: .touchUpInside)
        button.backgroundColor = .green
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonTapped))
        self.addSubviews()
        self.setConstraints()
    }
    
    // MARK: - Add subviews
    
    private func addSubviews() {
        self.view.addSubview(self.priorityStackView)
        self.priorityStackView.addSubview(self.redPriorityButton)
        self.priorityStackView.addSubview(self.blackPriorityButton)
        self.priorityStackView.addSubview(self.bluePriorityButton)
        self.priorityStackView.addSubview(self.greenPriorityButton)
        self.view.addSubview(self.titleTextField)
        self.view.addSubview(self.decriptionTextField)
    }
    
    // MARK: - Set constraints
    
    private func setConstraints() {
        let viewHeight = self.view.frame.height
        let priorityStackWidth = self.view.frame.width - 20
        let priorityStackHeight = priorityStackWidth/4

        self.priorityStackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().inset(10)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.height.equalTo(priorityStackHeight)
        }
        
        self.redPriorityButton.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(priorityStackWidth/4)
        }

        self.blackPriorityButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(self.redPriorityButton.snp.right)
            $0.width.equalTo(priorityStackWidth/4)
        }

        self.bluePriorityButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(self.blackPriorityButton.snp.right)
            $0.width.equalTo(priorityStackWidth/4)
        }

        self.greenPriorityButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(self.bluePriorityButton.snp.right)
            $0.width.equalTo(priorityStackWidth/4)
        }
        
        self.titleTextField.snp.makeConstraints {
            $0.left.equalTo(self.priorityStackView.snp.left)
            $0.right.equalTo(self.priorityStackView.snp.right)
            $0.top.equalTo(self.priorityStackView.snp.bottom).offset(viewHeight/20)
            $0.height.equalTo(50)
        }

        self.decriptionTextField.snp.makeConstraints {
            $0.left.equalTo(self.titleTextField.snp.left)
            $0.right.equalTo(self.titleTextField.snp.right)
            $0.top.equalTo(self.titleTextField.snp.bottom).offset(viewHeight/20)
            $0.height.equalTo(viewHeight/4)
        }
    }
    
    // MARK: - New task creating
    
    private func newTaskCreating(priority: String, title: String, description: String) {
        let newTask: TaskModel = TaskModel(taskTitle: title, taskDescription: description, priorityLevel: priority)
        self.newTask = newTask
    }
    
    // MARK: - Active priority buttons updater
    
    private func priorityButtonsStatusCleanerUpdater(_ button: UIButton) {
        self.redPriorityButton.backgroundColor = .red
        self.blackPriorityButton.backgroundColor = .black
        self.bluePriorityButton.backgroundColor = .blue
        self.greenPriorityButton.backgroundColor = .green
        
        switch button {
        case self.redPriorityButton:
            self.redPriorityButton.tag += 1
            self.blackPriorityButton.tag = 1
            self.bluePriorityButton.tag = 1
            self.greenPriorityButton.tag = 1
            
        case self.blackPriorityButton:
            self.redPriorityButton.tag = 1
            self.blackPriorityButton.tag += 1
            self.bluePriorityButton.tag = 1
            self.greenPriorityButton.tag = 1
            
        case self.bluePriorityButton:
            self.redPriorityButton.tag = 1
            self.blackPriorityButton.tag = 1
            self.bluePriorityButton.tag += 1
            self.greenPriorityButton.tag = 1
            
        case self.greenPriorityButton:
            self.redPriorityButton.tag = 1
            self.blackPriorityButton.tag = 1
            self.bluePriorityButton.tag = 1
            self.greenPriorityButton.tag += 1
        default:
            break
        }
    }
    
    // MARK: - Button tag checker
    
    private func isButtonActivated(_ button: UIButton) -> Bool {
        let tag = button.tag
        
        switch tag % 2 {
        case 0: return true
        default: return false
        }
    }
}

// MARK: - IBActions

extension TaskAddingViewController {
    @objc private func redPriorityButtonTapped() {
        self.priorityButtonsStatusCleanerUpdater(self.redPriorityButton)
        
        switch self.isButtonActivated(self.redPriorityButton) {
        case true:
            self.redPriorityButton.backgroundColor = .darkGray
        case false:
            self.redPriorityButton.backgroundColor = .red
        }
    }
    
    @objc private func blackPriorityButtonTapped() {
        self.priorityButtonsStatusCleanerUpdater(self.blackPriorityButton)
        
        switch self.isButtonActivated(self.blackPriorityButton) {
        case true:
            self.blackPriorityButton.backgroundColor = .darkGray
        case false:
            self.blackPriorityButton.backgroundColor = .black
        }
    }
    
    @objc private func bluePriorityButtonTapped() {
        self.priorityButtonsStatusCleanerUpdater(self.bluePriorityButton)
        
        switch self.isButtonActivated(self.bluePriorityButton) {
        case true:
            self.bluePriorityButton.backgroundColor = .darkGray
        case false:
            self.bluePriorityButton.backgroundColor = .blue
        }
    }
    
    @objc private func greenPriorityButtonTapped() {
        self.priorityButtonsStatusCleanerUpdater(self.greenPriorityButton)
        
        switch self.isButtonActivated(self.greenPriorityButton) {
        case true:
            self.greenPriorityButton.backgroundColor = .darkGray
        case false:
            self.greenPriorityButton.backgroundColor = .green
        }
    }
    
    @objc private func doneButtonTapped() {
        if self.titleTextField.text == "" {
            self.alertMessage("Please enter task title")
        } else {
            self.newTaskCreating(priority: "red_flag", title: self.titleTextField.text ?? "", description: self.decriptionTextField.text ?? "")
            print("doneButtonTapped")
            dump(self.newTask)
        }
    }
}
