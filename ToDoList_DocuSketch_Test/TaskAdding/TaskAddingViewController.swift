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
        return view
    }()
    
    private lazy var redPriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    private lazy var blackPriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    private lazy var bluePriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    private lazy var greenPriorityButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        return textField
        
    }()
    
    lazy var decriptionTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setView()
        self.addSubviews()
        self.setConstraints()
    }
    
    // MARK: - Set view
    
    private func setView() {
        self.view.backgroundColor = .white
        self.setNavigationBar()
        self.setPriorityStackView()
        self.setPriorityButtons()
        self.setTextFields()
    }
    
    func setNavigationBar() {
        self.navigationItem.title = NavigationTitles.adding.rawValue
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                 target: self,
                                                                 action: #selector(self.doneButtonTapped))
    }
    
    private func setPriorityStackView() {
        self.priorityStackView.axis = .horizontal
    }
    
    private func setPriorityButtons() {
        let buttons = [self.redPriorityButton, self.blackPriorityButton, self.bluePriorityButton, self.greenPriorityButton]
        
        buttons.forEach {
            $0.addTarget(self, action: #selector(self.priorityButtonTapped(sender: )), for: .touchUpInside)
            $0.tag = 1
            switch $0 {
            case self.redPriorityButton:
                $0.setImage(UIImage(named: PriorityImagesNames.red.rawValue), for: .normal)
            case self.blackPriorityButton:
                $0.setImage(UIImage(named: PriorityImagesNames.black.rawValue), for: .normal)
            case self.bluePriorityButton:
                $0.setImage(UIImage(named: PriorityImagesNames.blue.rawValue), for: .normal)
            case self.greenPriorityButton:
                $0.setImage(UIImage(named: PriorityImagesNames.green.rawValue), for: .normal)
            default:
                break
            }
        }
    }
    
    func setTextFields() {
        let textFields = [self.titleTextField, self.decriptionTextField]
        
        textFields.forEach {
            $0.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.isUserInteractionEnabled = true
            $0.delegate = self
            
            switch $0 {
            case self.titleTextField:
                $0.placeholder = PlaceholderText.title.rawValue
            case self.decriptionTextField:
                $0.placeholder = PlaceholderText.description.rawValue
                $0.contentVerticalAlignment = .top
            default:
                break
            }
        }
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
            $0.height.equalTo(viewHeight/6)
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

// MARK: - UITextFieldDelegate

extension TaskAddingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
            self.alertMessage(AlertMessages.title.rawValue)
        case false:
            guard let title = self.titleTextField.text else { return }
            guard let description = self.decriptionTextField.text else { return }
            self.newTaskCreating(priority: self.priorityLevel,
                                 title: title,
                                 description: description)
            self.closure?(self.newTask)
            self.navigationController?.popViewController(animated: true)
        }        
    }
}
