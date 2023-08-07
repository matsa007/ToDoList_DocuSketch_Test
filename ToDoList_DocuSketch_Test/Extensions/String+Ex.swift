//
//  String+Ex.swift
//  ToDoList_DocuSketch_Test
//
//  Created by Сергей Матвеенко on 7.08.23.
//

import UIKit

extension String {
    func createAttributedDescriptionText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString()

        let descriptionTitleAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: FontNames.bold.rawValue,
                                                                                       size: FontSizes.bold.rawValue) ?? UIFont.boldSystemFont(ofSize: 20)]
        
        let descriptionTitleString = NSAttributedString(string: "Description:", attributes: descriptionTitleAttributes)
        let descriptionTextAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: FontNames.regular.rawValue,
                                                                                      size: FontSizes.regular.rawValue) ?? UIFont.systemFont(ofSize: 15)]
        
        let descriptionTextString = NSAttributedString(string: "\n\n\(self)", attributes: descriptionTextAttributes)
        attributedString.append(descriptionTitleString)
        attributedString.append(descriptionTextString)
        return attributedString
    }
}
