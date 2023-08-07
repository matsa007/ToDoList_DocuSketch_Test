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
    
    private let userDefaultsService = UserDefaultsService()
    
    private var unfinishedTasksData: [TaskModel] {
        get {
            self.userDefaultsService.readFromUserDefaults(key: UserDefaultsKeys.unfinised.rawValue)
        }
        
        set {
            self.userDefaultsService.saveToUserDefaults(newValue, key: UserDefaultsKeys.unfinised.rawValue)
            self.displayDataCreating()
        }
    }
    
    private var finishedTasksData: [TaskModel] {
        get {
            self.userDefaultsService.readFromUserDefaults(key: UserDefaultsKeys.finished.rawValue)
        }
        
        set {
            self.userDefaultsService.saveToUserDefaults(newValue, key: UserDefaultsKeys.finished.rawValue)
            self.displayDataCreating()
        }
    }
    
    private var displayData = [[TaskModel]]() {
        didSet {
            self.listofTasksTableView.reloadData()
        }
    }
        
    // MARK: - GUI
    
    private lazy var listofTasksTableView = UITableView()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayDataCreating()
        self.setView()
        self.addSubviews()
        self.setConstraints()
    }
    
    // MARK: - Set view
    
    private func setView() {
        self.view.backgroundColor = .white
        self.setNavigationBar()
        self.setTableView()
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = NavigationTitles.list.rawValue
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(self.addNewtaskTapped))
    }
    
    private func setTableView() {
        let tableView = self.listofTasksTableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(ListOfTasksTableViewCell.self, forCellReuseIdentifier: CellsNames.list.rawValue)
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
        let displayDataCreationService = DisplayDataCreator()
        self.displayData = displayDataCreationService.displayDataCreating(unfinishedTasksData: self.unfinishedTasksData,
                                                                          finishedTasksData: self.finishedTasksData)
    }
    
    // MARK: - Moving and marking tasks as finished
    
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
    }
    
    private func finishedTasksPainter(_ section: Int, _ label: UILabel) {
        switch section {
        case 0:
            label.textColor = .black
        case 1:
            label.textColor = .lightGray
        default:
            break
        }
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
            return SectionsNames.first.rawValue
        case 1:
            return SectionsNames.second.rawValue
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellsNames.list.rawValue, for: indexPath) as? ListOfTasksTableViewCell else { return UITableViewCell() }
        
        self.finishedTasksPainter(indexPath.section, cell.taskTitleLabel)
        cell.taskStatusButton.tag = indexPath.row
        
        cell.closure = { [weak self] tag in
            guard let self else { return }
            self.finishedTasksUpdater(section: indexPath.section, index: tag)
        }
        
        cell.setCellView(title: self.displayData[indexPath.section][indexPath.row].taskTitle,
                         priority: self.displayData[indexPath.section][indexPath.row].priorityLevel ?? "",
                         section: indexPath.section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch indexPath.section {
            case 0:
                self.listofTasksTableView.beginUpdates()
                self.unfinishedTasksData.remove(at: indexPath.row)
                self.listofTasksTableView.deleteRows(at: [indexPath], with: .fade)
                self.listofTasksTableView.endUpdates()
            case 1:
                self.listofTasksTableView.beginUpdates()
                self.finishedTasksData.remove(at: indexPath.row)
                self.listofTasksTableView.deleteRows(at: [indexPath], with: .fade)
                self.listofTasksTableView.endUpdates()
            default:
                break
            }
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

