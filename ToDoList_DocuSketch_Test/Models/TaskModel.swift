//
//  TaskModel.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 5.08.23.
//

import Foundation

struct TaskModel: Codable {
    let taskTitle: String
    let taskDescription: String?
    let priorityLevel: String?
}
