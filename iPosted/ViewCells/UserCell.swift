//
//  UserCell.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import UIKit

class UserCell : UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    func configCell(with user: User) {
        nameLabel.text = user.name
        userNameLabel.text = user.userName
        emailLabel.text = user.email
        addressLabel.text = user.address?.description ?? "--"
    }
    
}
