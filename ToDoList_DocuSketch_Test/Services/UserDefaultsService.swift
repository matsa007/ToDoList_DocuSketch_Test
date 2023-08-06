//
//  UserDefaultsService.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 6.08.23.
//

import Foundation

struct UserDefaultsService {
    private let defaults = UserDefaults.standard
    
    func saveToUserDefaults(_ taskData: [TaskModel], key: String) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(taskData) {
            self.defaults.set(data, forKey: key)
        }
    }
    
    func readFromUserDefaults(key: String) -> [TaskModel] {
        if let data = self.defaults.data(forKey: key) {
            let decoder = JSONDecoder()
            if let tasks = try? decoder.decode([TaskModel].self, from: data) {
                return tasks
            }
        }
        return []
    }
}
