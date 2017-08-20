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
