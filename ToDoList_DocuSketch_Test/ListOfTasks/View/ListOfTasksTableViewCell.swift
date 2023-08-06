//
//  ListOfTasksTableViewCell.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 5.08.23.
//

import UIKit

final class ListOfTasksTableViewCell: UITableViewCell {
    
    // MARK: - Parameters
    
    var closure: ((Int) -> ())?
    
    // MARK: - GUI
    
    lazy var taskStatusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.taskStatusButtontapped), for: .touchUpInside)
        return button
    }()
    
    lazy var taskTitleLabel: UILabel = {
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
    
    func setCellView(title: String, priority: String, section: Int) {
        self.taskTitleLabel.text = title
        self.priorityImageView.image = UIImage(named: priority)
        
        switch section {
        case 0:
            self.taskStatusButton.setImage(UIImage(named: "unchecked_checkbox"), for: .normal)
        case 1:
            self.taskStatusButton.setImage(UIImage(named: "checked_checkbox"), for: .normal)
        default:
            break
        }
    }
}

// MARK: - IBActions

extension ListOfTasksTableViewCell {
    @objc private func taskStatusButtontapped() {
        print("taskStatusButtontapped")
        print("# = \(self.taskStatusButton.tag)")
        self.closure?(self.taskStatusButton.tag)
    }
}
