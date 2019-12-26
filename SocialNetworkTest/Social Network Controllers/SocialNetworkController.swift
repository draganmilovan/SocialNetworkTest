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
            
            updateUI()
        }
    }

    @IBOutlet private weak var membersTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(notification:)),
                                               name: Notification.Name("DataUpdated"),
                                               object: nil)
    }


}



//MARK:- Table View Data Source Protocol Methods
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



//MARK:- Table View Delegate Methods
extension SocialNetworkController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataManager = dataManager else {
            fatalError("Missing Data Manager!")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fc = storyboard.instantiateViewController(withIdentifier: "FriendsController") as! FriendsController
        
        dataManager.populateMembersFriends(for: dataManager.members[indexPath.row])
        
        fc.dataManager = dataManager
        fc.title = dataManager.members[indexPath.row].firstName + "'s"
        
        show(fc, sender: self)
        
    }
    
}



//MARK:- Social Network Controller private methods
private extension SocialNetworkController {
    
    //
    // Method for handling received Notification
    //
    @objc func notificationReceived(notification: NSNotification){
        
        updateUI()
    }
    
    
    //
    // Method for updating UI
    //
    func updateUI() {
        
        activityIndicator.stopAnimating()
        membersTableView.reloadData()
    }
    
}
