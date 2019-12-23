//
//  FriendsController.swift
//  SocialNetworkTest
//
//  Created by Dragan Milovanovic on 12/23/19.
//  Copyright © 2019 Dragan Milovanovic. All rights reserved.
//

import UIKit

class FriendsController: UIViewController {

    // Data source
    var dataManager: DataManager? {
        didSet {
            if !self.isViewLoaded { return }
            
            membersFriendsCollectionView.reloadData()
            friendsFriendsCollectionView.reloadData()
            suggestedFriendsCollectonView.reloadData()
        }
    }
        
    @IBOutlet private weak var friendsLabel: UILabel!
    @IBOutlet private weak var friendsFriendsLabel: UILabel!
    @IBOutlet private weak var suggestedFriendsLabel: UILabel!
    @IBOutlet private weak var membersFriendsCollectionView: UICollectionView!
    @IBOutlet private weak var friendsFriendsCollectionView: UICollectionView!
    @IBOutlet private weak var suggestedFriendsCollectonView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionViewsCell()
        cleanLabels()
        populateLabels()
    }

}



//MARK: - Friends Controller private methods
private extension FriendsController {
    
    //
    // Method clean text from all Labels
    //
    func cleanLabels() {
        friendsLabel.text = nil
        friendsFriendsLabel.text = nil
        suggestedFriendsLabel.text = nil
    }
    
    //
    // Method populate labels with text
    //
    func populateLabels() {
        guard let dataManager = dataManager else {
            fatalError("Missing Data Manager!")
        }
    
        if !dataManager.membersFriends.isEmpty {
            friendsLabel.text = "Friends"
        } else {
            friendsLabel.text = "No Friends Yet :("
        }
        
        if !dataManager.membersFriendsFriends.isEmpty {
            friendsFriendsLabel.text = "Friend's Friends"
        } else {
            friendsFriendsLabel.text = "Connected to All Friend's Friends"
        }
        
        if !dataManager.membersSuggestedFriends.isEmpty {
            suggestedFriendsLabel.text = "Suggested Friends"
        } else {
            suggestedFriendsLabel.text = "No Suggested Friends :("
        }
    }
    
}




//MARK:- Collection View Data Source Protocol Methods
extension FriendsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let dataManager = dataManager else {
            fatalError("Missing Data Manager!")
        }
        
        if collectionView == membersFriendsCollectionView {
            return dataManager.membersFriends.count
            
        } else if collectionView == friendsFriendsCollectionView {
            return dataManager.membersFriendsFriends.count
            
        } else {
            return dataManager.membersSuggestedFriends.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataManager = dataManager else {
            fatalError("Missing Data Manager!")
        }
        
        let cell: FriendsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
        if collectionView == membersFriendsCollectionView {
            cell.member = dataManager.membersFriends[indexPath.item]
            
        } else if collectionView == friendsFriendsCollectionView {
            cell.member = dataManager.membersFriendsFriends[indexPath.item]

        } else {
            cell.member = dataManager.membersSuggestedFriends[indexPath.item]
        }
        
        return cell
    }
    
}



//MARK:- Collection View Flow Layout Protocol Methods
extension FriendsController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let availableHeight = collectionView.bounds.size.height
        
        let availableItemHeight = availableHeight - flowLayout.sectionInset.top - flowLayout.sectionInset.bottom
        
        let itemWidth = availableItemHeight
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
}



//MARK:- Collection View private methods
fileprivate extension FriendsController {
    
    //
    // Method register Cell from Nibs to all Collection Views
    //
    func registerCollectionViewsCell() {
        
        let memberNib = UINib(nibName: "FriendsCell", bundle: nil)
        membersFriendsCollectionView.register(memberNib, forCellWithReuseIdentifier: "FriendsCell")
        friendsFriendsCollectionView.register(memberNib, forCellWithReuseIdentifier: "FriendsCell")
        suggestedFriendsCollectonView.register(memberNib, forCellWithReuseIdentifier: "FriendsCell")
    }
    
}
