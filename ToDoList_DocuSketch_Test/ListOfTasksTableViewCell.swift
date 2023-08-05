//
//  ListOfTasksTableViewCell.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 5.08.23.
//

import UIKit

final class ListOfTasksTableViewCell: UITableViewCell {
    
    // MARK: - GUI
    
    private lazy var taskStatusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.taskStatusButtontapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var taskTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var priorityImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.taskStatusButton.imageView?.image = nil
        self.taskTitleLabel.text = nil
        self.priorityImageView.image = nil

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    // MARK: - Add subviews
    
    private func addSubviews() {
        
    }
    
    // MARK: - Add constraints
    
    private func setConstraints() {
        
    }
    
    // MARK: - Set cell view
    
    func setCellView() {
        
    }
}

// MARK: - IBActions

extension ListOfTasksTableViewCell {
    @objc private func taskStatusButtontapped() {
        print("taskStatusButtontapped")
    }
}
