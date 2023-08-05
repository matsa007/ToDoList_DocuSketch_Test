//
//  ViewController.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 5.08.23.
//

import UIKit
import SnapKit

final class ListOfTasksViewController: UIViewController {
    
    // MARK: - GUI
    
    private lazy var listofTasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .green
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        self.setTableView()
        self.addSubviews()
        self.setConstraints()
    }
    
    private func setTableView() {
        self.listofTasksTableView.delegate = self
        self.listofTasksTableView.dataSource = self
        self.listofTasksTableView.register(ListOfTasksTableViewCell.self, forCellReuseIdentifier: "list_cell")
    }
    
    private func addSubviews() {
        self.view.addSubview(self.listofTasksTableView)
    }
    
    private func setConstraints() {
        self.listofTasksTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ListOfTasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "list_cell", for: indexPath) as? ListOfTasksTableViewCell else { return UITableViewCell() }
        return cell
    }
}

