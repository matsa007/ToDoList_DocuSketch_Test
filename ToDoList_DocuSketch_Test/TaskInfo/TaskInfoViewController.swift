//
//  TaskInfoViewController.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 5.08.23.
//

import UIKit

final class TaskInfoViewController: UIViewController {
    
    // MARK: - Parameters
    
    private var task: TaskModel
    private let position: TaskPosition
    var closure: ((TaskModel, TaskPosition) -> ())?
    
    // MARK: - GUI
    
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var priorityImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var descriptionlabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Initialization
        
    init(task: TaskModel, position: TaskPosition) {
        self.task = task
        self.position = position
        
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                                 target: self,
                                                                 action: #selector(self.editButtonTapped))
        self.addSubviews()
        self.setView()
        self.setConstraints()
    }
    
    // MARK: - Add subviews
    
    private func addSubviews() {
        self.view.addSubview(self.titlelabel)
        self.view.addSubview(self.priorityImageView)
        self.view.addSubview(self.descriptionlabel)
    }
    
    // MARK: - Set constraints
    
    private func setConstraints() {
        let titleWidth = (self.view.frame.width - 20) * 2/3
        let titleHeight = titleWidth/4

        self.titlelabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(titleHeight)
            $0.width.equalTo(titleWidth)
        }
        
        self.priorityImageView.snp.makeConstraints {
            $0.top.equalTo(self.titlelabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        self.descriptionlabel.snp.makeConstraints {
            $0.top.equalTo(self.priorityImageView.snp.bottom).offset(10)
            $0.width.equalTo(self.titlelabel.snp.width)
        }
    }
    
    private func setView() {
        self.setTitleLabel()
        self.setPriorityImage()
        self.setDescriptionLabel()
    }
    
    private func setTitleLabel() {
        self.titlelabel.text = self.task.taskTitle
        self.titlelabel.textAlignment = .center
    }
    
    private func setPriorityImage() {
        guard let imageName = self.task.priorityLevel else { return }
        self.priorityImageView.image = UIImage(named: imageName)
    }
    
    private func setDescriptionLabel() {
        self.descriptionlabel.text = self.task.taskDescription
    }
}

// MARK: - IBActions

extension TaskInfoViewController {
    @objc private func editButtonTapped() {
        let vc = TaskEditingViewController(task: self.task)
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.completion = { [weak self] task in
            guard let self else { return }
            self.task = task
            self.titlelabel.text = self.task.taskTitle
            self.descriptionlabel.text = self.task.taskDescription
            guard let imageName = self.task.priorityLevel else { return }
            self.priorityImageView.image = UIImage(named: imageName)
            self.closure?(self.task, self.position)
        }
        
        vc.closureVoid = { [weak self] in
            guard let self else { return }
            self.task = TaskModel(taskTitle: "", taskDescription: "", priorityLevel: "")
            self.closure?(self.task, self.position)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
