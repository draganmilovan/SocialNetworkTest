//
//  ViewController.swift
//  SocialNetworkTest
//
//  Created by Dragan Milovanovic on 12/19/19.
//  Copyright © 2019 Dragan Milovanovic. All rights reserved.
//

import UIKit

class SocialNetworkController: UIViewController {
    
    var dataManager: DataManager? {
        didSet {
            if !self.isViewLoaded { return }
            
            membersTableView.reloadData()
        }
    }

    @IBOutlet private weak var membersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}



//Mark:- Table View Data Source Protocol Methods
extension SocialNetworkController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataManager = dataManager else {
            fatalError("Missing Data Manager!")
        }
        
        return dataManager.members.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataManager = dataManager else {
            fatalError("Missing Data Manager!")
        }
        let cell = membersTableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell", for: indexPath) as! MemberTableViewCell
        
        cell.member = dataManager.members[indexPath.row]
        
        return cell
    }
    
}



//Mark:- Table View Delegate Methods
extension SocialNetworkController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let dataManager = dataManager else {
//            fatalError("Missing Data Manager!")
//        }
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
    }
    
}
