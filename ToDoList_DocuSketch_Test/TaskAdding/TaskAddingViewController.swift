//
//  TaskAddingViewController.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 5.08.23.
//

import UIKit

class TaskAddingViewController: UIViewController {
    
    // MARK: - Parameters
    
    private var newTask = TaskModel(taskTitle: "", taskDescription: "", priorityLevel: "")
    var priorityLevel: String = ""
    var closure: ((TaskModel) -> ())?
    
    // MARK: - GUI
    
    private lazy var priorityStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    private lazy var redPriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.priorityButtonTapped(sender: )), for: .touchUpInside)
        button.tag = 1
        button.setImage(UIImage(named: PriorityImagesNames.red.rawValue), for: .normal)
        return button
    }()
    
    private lazy var blackPriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.priorityButtonTapped(sender: )), for: .touchUpInside)
        button.tag = 1
        button.setImage(UIImage(named: PriorityImagesNames.black.rawValue), for: .normal)
        return button
    }()
    
    private lazy var bluePriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.priorityButtonTapped(sender: )), for: .touchUpInside)
        button.tag = 1
        button.setImage(UIImage(named: PriorityImagesNames.blue.rawValue), for: .normal)
        return button
    }()
    
    private lazy var greenPriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.priorityButtonTapped(sender: )), for: .touchUpInside)
        button.tag = 1
        button.setImage(UIImage(named: PriorityImagesNames.green.rawValue), for: .normal)
        return button
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type your task title here ..."
        textField.backgroundColor = .lightGray
        return textField
        
    }()
    
    lazy var decriptionTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.placeholder = "Type your task decription here ..."
        return textField
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                 target: self,
                                                                 action: #selector(self.doneButtonTapped))
        self.navigationItem.title = "Add new task"
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
        let priorityStackWidth = (self.view.frame.width - 20) * 2/3
        let priorityStackHeight = priorityStackWidth/4

        self.priorityStackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(priorityStackHeight)
            $0.width.equalTo(priorityStackWidth)
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
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().inset(10)
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
    
    // MARK: - Active priority buttons updater and cleaner
    
    private func priorityButtonsStatusUpdater(_ button: UIButton) {
        self.priorityButtonsStatusCleaner()
        
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
    
    private func priorityButtonsStatusCleaner() {
        self.redPriorityButton.backgroundColor = .clear
        self.blackPriorityButton.backgroundColor = .clear
        self.bluePriorityButton.backgroundColor = .clear
        self.greenPriorityButton.backgroundColor = .clear
        self.priorityLevel = ""
    }
    
    // MARK: - Button tag checker
    
    private func isButtonActivated(_ button: UIButton) -> Bool {
        let tag = button.tag
        
        switch tag % 2 {
        case 0:
            return true
        default:
            return false
        }
    }
    
    // MARK: - Blank data checkers
    
    private func checkForBlankTitle() -> Bool {
        self.titleTextField.text == ""
    }
    
    private func checkForBlankPriority() -> Bool {
        self.priorityLevel == ""
    }
    
    // MARK: - Priority level updater
    
    private func priorityLevelUpdater(_ button: UIButton) {
        self.priorityButtonsStatusUpdater(button)
        switch self.isButtonActivated(button) {
        case true:
            button.backgroundColor = .lightGray
            self.priorityLevel = self.priorityNameFinder(button)
        case false:
            break
        }
    }
    
    private func priorityNameFinder(_ button: UIButton) -> String {
        switch button {
        case self.redPriorityButton:
            return PriorityImagesNames.red.rawValue
        case self.blackPriorityButton:
            return PriorityImagesNames.black.rawValue
        case self.bluePriorityButton:
            return PriorityImagesNames.blue.rawValue
        case self.greenPriorityButton:
            return PriorityImagesNames.green.rawValue
        default:
            return ""
        }
    }
}

// MARK: - IBActions

extension TaskAddingViewController {
    @objc private func priorityButtonTapped(sender: UIButton) {
        self.priorityLevelUpdater(sender)
    }
    
    @objc func doneButtonTapped() {
        switch self.checkForBlankTitle() {
        case true:
            self.alertMessage("Please enter task title")
        case false:
            self.newTaskCreating(priority: self.priorityLevel,
                                 title: self.titleTextField.text ?? "No title",
                                 description: self.decriptionTextField.text ?? "No description ...")
            self.closure?(self.newTask)
            self.navigationController?.popViewController(animated: true)
        }        
    }
}
