//
//  PostsDataProvider.swift
//  iPosted
//
//  Created by Antonio da Silva on 20/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import UIKit

class PostsDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Variables
    
    var posts: [Post]?
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        let rows = posts?.count ?? 0
        if rows == 0 {
            tableView.setEmptyMessage("loading posts...".localized)
        }  else {
            tableView.restore()
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        if let post = posts?[indexPath.row] {
            cell.configCell(with: post)
        }
        return cell
    }
    
}
