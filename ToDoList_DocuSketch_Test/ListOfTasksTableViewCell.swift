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
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(self.taskStatusButtontapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var taskTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        return label
    }()
    
    private lazy var priorityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
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
        
        self.addSubviews()
        self.setConstraints()
    }
    
    // MARK: - Add subviews
    
    private func addSubviews() {
        self.contentView.addSubview(self.taskStatusButton)
        self.contentView.addSubview(self.taskTitleLabel)
        self.contentView.addSubview(self.priorityImageView)
    }
    
    // MARK: - Add constraints
    
    private func setConstraints() {
        let cellWidth = self.contentView.frame.width

        self.taskStatusButton.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(cellWidth/12)
        }
        
        self.priorityImageView.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
            $0.width.equalTo(cellWidth/12)
        }
        
        self.taskTitleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(self.taskStatusButton.snp.right)
            $0.right.equalTo(self.priorityImageView.snp.left)
        }
    }
    
    // MARK: - Set cell view
    
    func setCellView(title: String) {
        self.taskTitleLabel.text = title
    }
}

// MARK: - IBActions

extension ListOfTasksTableViewCell {
    @objc private func taskStatusButtontapped() {
        print("taskStatusButtontapped")
    }
}
