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
            print(self.unfinishedTasksData)
        }
    }
    
    private var finishedTasksData: [TaskModel] = [] {
        didSet {
            print(self.unfinishedTasksData)
        }
    }
    
    private var displayData: [[TaskModel]] = [[]]
    
    var dataa = ["1","2","3"]
    
    // MARK: - GUI
    
    private lazy var listofTasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}

// MARK: - Extensions

extension ListOfTasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataa.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "list_cell", for: indexPath) as? ListOfTasksTableViewCell else { return UITableViewCell() }
        cell.setCellView(title: self.dataa[indexPath.row])
        return cell
    }
}

// MARK: - IBActions

extension ListOfTasksViewController {
    @objc private func addNewtaskTapped() {
        let vc = TaskAddingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

