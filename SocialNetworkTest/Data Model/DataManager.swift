//
//  DataManager.swift
//  SocialNetworkTest
//
//  Created by Dragan Milovanovic on 12/19/19.
//  Copyright © 2019 Dragan Milovanovic. All rights reserved.
//

import Foundation


final class DataManager {
    
    var members: [MemberDataModel] = [] {
        didSet {
            postNotification()
        }
    }

    var membersFriends: [MemberDataModel] = []
    var membersFriendsFriends: [MemberDataModel] = []
    var membersSuggestedFriends: [MemberDataModel] = []
    
    
    init() {
        populateMembers()
    }
    
}



// MARK:- Data Manager private methods
fileprivate extension DataManager {
    
    //
    // Method for populating members Array
    //
    func populateMembers() {
        
        DispatchQueue.global(qos: .background).async {
            [unowned self ] in
            
            var mmbrs: [MemberDataModel] = []
            
            guard let url = Bundle.main.path(forResource: "data", ofType: "json") else {
                fatalError("Missing data JSON!")
            }
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: url))

                mmbrs = try JSONDecoder().decode([MemberDataModel].self, from: data)
            }
            catch {
                print("JSON error")
            }
            
            DispatchQueue.main.async {
                self.members.append(contentsOf: mmbrs)
            }
        }

    }
        
    //
    // Method remove data from all member's friends arrays
    //
    func removeAllFriendsData() {
        
        membersFriends.removeAll()
        membersFriendsFriends.removeAll()
        membersSuggestedFriends.removeAll()
    }
    
    //
    // Method for posting Notification after parsing JSON
    //
    func postNotification() {
        NotificationCenter.default.post(name: Notification.Name("DataUpdated"),
                                        object: nil)
    }
    
}



// MARK:- Data Manager member's friends arays populating methods
extension DataManager {
    
    //
    // Method for populating membersFriends Array
    //
    func populateMembersFriends(for member: MemberDataModel) {
        
        removeAllFriendsData()
        
        membersFriends = populateMembersArray(from: member.friends)
        
        populateMembersFriendsFriends(for: member)
        
    }
    
    //
    // Method for populating membersFriendsFriends Array
    //
    fileprivate func populateMembersFriendsFriends(for member: MemberDataModel) {
        
        let all: [Int] = { findAllFriendsFriendsIDs(for: member) }()
        var ff: [Int] = []
        
        // Removing duplicates
        let _ = all.compactMap {
            if !ff.contains($0) {
                ff.append($0)
            }
        }
        
        ff = removeExistingFriends(for: member, from: ff)
        
        membersFriendsFriends = populateMembersArray(from: ff)

        populateMembersSuggestedFriends(for: member)
        
    }
    
    //
    // Method for populating membersSuggestedFriends Array
    //
    fileprivate func populateMembersSuggestedFriends(for member: MemberDataModel) {
        
        var ff: [Int] = { findAllFriendsFriendsIDs(for: member) }()
        var sf: [Int] = []
        
        ff = removeExistingFriends(for: member, from: ff)
        sf = ff.duplicates()
        
        membersSuggestedFriends = populateMembersArray(from: sf)

    }
    
    
    //
    // Method return all IDs find in friends frends
    //
    fileprivate func findAllFriendsFriendsIDs(for member: MemberDataModel) -> [Int] {
        
        var allPlusMemeber: [Int] = []
        var all: [Int] = []
        
        let _ = membersFriends.compactMap {
            allPlusMemeber.append(contentsOf: $0.friends)
        }
        
        let _ = allPlusMemeber.compactMap {
            if ($0 != member.id) {
                all.append($0)
            }
        }
        
        return all
    }
    
    //
    // Method return array of IDs minus member's frends IDs
    //
    fileprivate func removeExistingFriends(for member: MemberDataModel, from all: [Int]) -> [Int] {
        
        var friends = all
        
        let _ = member.friends.compactMap {
            for (index, element) in friends.enumerated() {
                if element == $0 {
                    friends.remove(at: index)
                }
            }
        }
        
        return friends
    }
    
    //
    // Method returns array of Members Data Models from their IDs
    //
    fileprivate func populateMembersArray(from membersIDs: [Int]) -> [MemberDataModel] {
        
        var mmbrs: [MemberDataModel] = []
        
        let _ = membersIDs.compactMap {
            let id = $0
            let _ = members.compactMap {
                if $0.id == id {
                    mmbrs.append($0)
                }
            }
        }
        
        return mmbrs
    }
    
}




extension Array where Element: Hashable {
    
    func duplicates() -> Array {
        let groups = Dictionary(grouping: self, by: {$0})
        let duplicateGroups = groups.filter {$1.count > 1}
        let duplicates = Array(duplicateGroups.keys)
        return duplicates
    }
    
}
