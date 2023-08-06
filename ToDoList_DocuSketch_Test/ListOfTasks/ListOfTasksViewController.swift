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
    
    private let defaults = UserDefaults.standard
    
    private var unfinishedTasksData: [TaskModel] {
        get {
            self.readFromUserDefaults(key: "unfinishedTasksData")
        }
        
        set {
            self.saveToUserDefaults(newValue, key: "unfinishedTasksData")
        }
    }
    
    private var finishedTasksData: [TaskModel] {
        get {
            self.readFromUserDefaults(key: "finishedTasksData")
        }
        
        set {
            self.saveToUserDefaults(newValue, key: "finishedTasksData")
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
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(self.addNewtaskTapped))
        self.navigationItem.title = "ToDo List"
        self.setTableView()
        self.addSubviews()
        self.setConstraints()
    }
    
    private func setTableView() {
        self.listofTasksTableView.delegate = self
        self.listofTasksTableView.dataSource = self
        self.listofTasksTableView.register(ListOfTasksTableViewCell.self, forCellReuseIdentifier: "list_cell")
    }
    
    // MARK: - Save and read from UserDefaults
    
    private func saveToUserDefaults(_ taskData: [TaskModel], key: String) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(taskData) {
            UserDefaults.standard.set(data, forKey: key)
        }
        self.displayDataCreating()
    }
    
    private func readFromUserDefaults(key: String) -> [TaskModel] {
        if let data = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            if let tasks = try? decoder.decode([TaskModel].self, from: data) {
                return tasks
            }
        }
        return []
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
        
        self.listofTasksTableView.reloadData()
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

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListOfTasksViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        self.displayData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Unfinished tasks:"
        case 1:
            return "Finished tasks:"
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
        cell.taskStatusButton.tag = indexPath.row
        
        cell.closure = { [weak self] tag in
            guard let self else { return }
            self.finishedTasksUpdater(section: indexPath.section, index: tag)
        }
        
        switch indexPath.section {
        case 0:
            cell.taskTitleLabel.textColor = .black
        case 1:
            cell.taskTitleLabel.textColor = .lightGray
        default:
            break
        }
        
        cell.setCellView(title: self.displayData[indexPath.section][indexPath.row].taskTitle,
                         priority: self.displayData[indexPath.section][indexPath.row].priorityLevel ?? "",
                         section: indexPath.section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.listofTasksTableView.beginUpdates()
            self.unfinishedTasksData.remove(at: indexPath.row)
            self.listofTasksTableView.deleteRows(at: [indexPath], with: .fade)
            self.listofTasksTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TaskInfoViewController(task: self.displayData[indexPath.section][indexPath.row], position: TaskPosition(section: indexPath.section, index: indexPath.row))
        self.navigationController?.pushViewController(vc, animated: true)
        let blankTitle = ""
        
        vc.closure = { [weak self] editedTask, position in
            guard let self else { return }

            if editedTask.taskTitle != blankTitle {
                switch position.section {
                case 0:
                    self.unfinishedTasksData[position.index] = editedTask
                case 1:
                    self.finishedTasksData[position.index] = editedTask
                default:
                    break
                }
            } else {
                switch position.section {
                case 0:
                    self.unfinishedTasksData.remove(at: position.index)
                case 1:
                    self.finishedTasksData.remove(at: position.index)
                default:
                    break
                }
            }
        }
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

