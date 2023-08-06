//
//  DisplayDataCreator.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 6.08.23.
//

import Foundation

struct DisplayDataCreator {
    func displayDataCreating(unfinishedTasksData: [TaskModel], finishedTasksData: [TaskModel]) -> [[TaskModel]] {
        var updatedDisplayData = [[TaskModel]]()
        
        if unfinishedTasksData.count > 0 {
            updatedDisplayData.append(unfinishedTasksData)
        }
                
        if finishedTasksData.count > 0 {
            updatedDisplayData.append(finishedTasksData)
        }
        
        return updatedDisplayData
//        self.listofTasksTableView.reloadData()
    }
}
