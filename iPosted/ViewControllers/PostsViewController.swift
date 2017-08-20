//
//  PostsViewController.swift
//  iPosted
//
//  Created by Antonio da Silva on 20/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!
    
    // MARK: - Variables
    
    var user: User?
    
    // MARK: - UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = dataProvider
        self.tableView.delegate = dataProvider
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
