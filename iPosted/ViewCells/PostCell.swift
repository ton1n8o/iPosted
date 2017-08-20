//
//  PostCell.swift
//  iPosted
//
//  Created by Antonio da Silva on 20/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(with post: Post) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
