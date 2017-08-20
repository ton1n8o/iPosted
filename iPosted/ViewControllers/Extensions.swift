//
//  Extensions.swift
//  iPosted
//
//  Created by Antonio da Silva on 20/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(with msg: String) {
        
        let alertViewController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
        }))
        
        self.present(alertViewController, animated: true, completion: nil)
    }
}

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        
        let frame = CGRect(
            x: 0,
            y: 0,
            width: self.bounds.size.width,
            height: self.bounds.size.height
        )
        
        let label = UILabel(frame: frame)
        label.text = message
        label.textColor = .black
        label.numberOfLines = 0;
        label.textAlignment = .center;
        label.font = UIFont(name: "Palatino-Italic", size: 22)
        label.sizeToFit()
        
        self.backgroundView = label;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension String {
    
    public var localized: String {
        return NSLocalizedString(
            self, tableName: nil, bundle: Bundle.main, value: "", comment: ""
        )
    }
}
