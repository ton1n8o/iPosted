//
//  PostsViewController.swift
//  iPosted
//
//  Created by Antonio da Silva on 20/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: PostsDataProvider?
    
    // MARK: - Variables
    
    lazy var apiClient = APIClient()
    var user: User?
    
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = dataProvider
        self.tableView.delegate = dataProvider
        dataProvider?.posts = [Post]()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let userId = user?.id else {
            return
        }
        
        apiClient.loadPosts(userId: userId) { (arrayPosts, error) in
            DispatchQueue.main.async {
                if arrayPosts != nil {
                    self.dataProvider?.posts = arrayPosts
                }
                self.tableView?.reloadData()
            }
        }
    }
    
    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
