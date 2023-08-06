//
//  UIViewController+Ex.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 5.08.23.
//

import UIKit

extension UIViewController {
    func alertMessage(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deletingAlertMessage(_ message: String, _ function: @escaping (UIAlertAction) -> ()) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Warning!",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel",
                                          style: .default,
                                          handler: nil))
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: function))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
