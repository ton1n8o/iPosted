//
//  UsersViewController.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView?
    @IBOutlet var dataProvider: UsersDataProvider!
    
    // MARK: - Variables
    
    lazy var apiClient = APIClient()
    
    // MARK: - UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = dataProvider
        tableView?.delegate = dataProvider
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView?.reloadData()
        apiClient.loadUsers { (arrayUsers, error) in
            if !(arrayUsers?.isEmpty ?? true) {
                self.dataProvider.users = arrayUsers
                self.tableView?.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

