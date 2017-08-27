//
//  UsersViewController.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, DidSelectUserDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView?
    @IBOutlet var dataProvider: UsersDataProvider!
    
    // MARK: - Variables
    
    lazy var apiClient = APIClient()
    fileprivate let refreshControl = UIRefreshControl()
    
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = dataProvider
        tableView?.delegate = dataProvider
        dataProvider.delegate = self
        
        setupRefreshControl()
        fetchUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = tableView?.indexPathForSelectedRow {
            tableView?.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: - DidSelectUserDelegate
    
    func didSelectUser(atIndex: Int) {
        performSegue(withIdentifier: "ShowUserPosts", sender: dataProvider.users?[atIndex])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let postsViewController = segue.destination as? PostsViewController {
            if let userSelected = sender as? User {
                postsViewController.user = userSelected
            }
        }
    }
    
}

extension UsersViewController {
    
    fileprivate func setupRefreshControl() {
        
        refreshControl.addTarget(
            self, action: #selector(refreshData(_:)), for: .valueChanged
        )
        
        if #available(iOS 10.0, *) {
            tableView?.refreshControl = refreshControl
        } else {
            tableView?.addSubview(refreshControl)
        }
    }
    
    @objc private func refreshData(_ sender: Any) {
        fetchUsers()
    }
    
    fileprivate func fetchUsers() {
        
        apiClient.loadUsers { [weak self] (arrayUsers, error) in
            
            if let arrayUsers = arrayUsers {
                self?.dataProvider.users = arrayUsers
            }
            
            DispatchQueue.main.async {
            
                if error != nil {
                    // TODO: we may validate the error type here and present another message.
                    self?.showAlert(with: Constants.NETWORK_ERROR.localized)
                }
                
                self?.tableView?.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
}

