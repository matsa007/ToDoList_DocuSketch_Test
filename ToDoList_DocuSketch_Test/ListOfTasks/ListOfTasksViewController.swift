//
//  ViewController.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 5.08.23.
//

import UIKit
import SnapKit

final class ListOfTasksViewController: UIViewController {
    
    // MARK: - Parameters
    
    private var unfinishedTasksData: [TaskModel] = [] {
        didSet {
            self.displayDataCreating()
            self.listofTasksTableView.reloadData()

        }
    }
    
    private var finishedTasksData: [TaskModel] = [] {
        didSet {
        }
    }
    
    private var displayData = [[TaskModel]]() {
        didSet {
            self.listofTasksTableView.reloadData()
        }
    }
        
    // MARK: - GUI
    
    private lazy var listofTasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayDataCreating()
        self.view.backgroundColor = .lightGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNewtaskTapped))
        self.setTableView()
        self.addSubviews()
        self.setConstraints()
    }
    
    private func setTableView() {
        self.listofTasksTableView.delegate = self
        self.listofTasksTableView.dataSource = self
        self.listofTasksTableView.register(ListOfTasksTableViewCell.self, forCellReuseIdentifier: "list_cell")
    }
    
    // MARK: - Add subviews
    
    private func addSubviews() {
        self.view.addSubview(self.listofTasksTableView)
    }
    
    // MARK: - Set constraints
    
    private func setConstraints() {
        self.listofTasksTableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    // MARK: - Display data creating
    
    private func displayDataCreating() {
        self.displayData.removeAll()
        
        if self.unfinishedTasksData.count > 0 {
            self.displayData.append(self.unfinishedTasksData)
        }
                
        if self.finishedTasksData.count > 0 {
            self.displayData.append(self.finishedTasksData)
        }
    }
    
    private func finishedTasksUpdater(section: Int, index: Int) {
        switch section {
        case 0:
            self.finishedTasksData.append(self.unfinishedTasksData[index])
            self.unfinishedTasksData.remove(at: index)
        case 1:
            self.unfinishedTasksData.append(self.finishedTasksData[index])
            self.finishedTasksData.remove(at: index)
        default:
            break
        }
        self.displayDataCreating()
    }
}

// MARK: - Extensions

extension ListOfTasksViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        self.displayData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Unfinished tasks:"
        case 1:
            return "Finished tasks"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.unfinishedTasksData.count
        case 1:
            return self.finishedTasksData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "list_cell", for: indexPath) as? ListOfTasksTableViewCell else { return UITableViewCell() }
        cell.setCellView(title: self.displayData[indexPath.section][indexPath.row].taskTitle, priority: self.displayData[indexPath.section][indexPath.row].priorityLevel ?? "")
        cell.taskStatusButton.tag = indexPath.row
        
        cell.closure = { [weak self] tag in
            guard let self else { return }
            self.finishedTasksUpdater(section: indexPath.section, index: tag)
        }
        return cell
    }
}

// MARK: - IBActions

extension ListOfTasksViewController {
    @objc private func addNewtaskTapped() {
        let vc = TaskAddingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.closure = { [weak self] newTask in
            guard let self else { return }
            self.unfinishedTasksData.append(newTask)
        }
    }
}

