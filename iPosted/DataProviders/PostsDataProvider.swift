//
//  PostsDataProvider.swift
//  iPosted
//
//  Created by Antonio da Silva on 20/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation
import UIKit

class PostsDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Variables
    
    var posts: [Post]?
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.configCell(with: Post(userId: 1, id: 1, title: "", body: ""))
        return cell
    }
    
}
