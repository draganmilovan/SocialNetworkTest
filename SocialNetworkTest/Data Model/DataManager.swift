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
            populateMembersFriends(for: self.members[4])
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
        
        guard let url = Bundle.main.path(forResource: "data", ofType: "json") else {
            fatalError("Missing data JSON!")
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: url))

            members = try JSONDecoder().decode([MemberDataModel].self, from: data)
        }
        catch {
            print("JSON error")
        }
    }
    
}



// MARK:- Data Manager member's friends arays populating methods
extension DataManager {
    
    //
    // Method for populating membersFriends Array
    //
    func populateMembersFriends(for member: MemberDataModel) {
        
        let _ = member.friends.compactMap {
            let id = $0
            let _ = members.compactMap {
                if $0.id == id {
                    membersFriends.append($0)
                }
            }
        }
        
    }
    
    //
    // Method for populating membersFriendsFriends Array
    //
    func populateMembersFriendsFriends() {
        
        
    }
    
    //
    // Method for populating membersSuggestedFriends Array
    //
    func populateMembersSuggestedFriends() {
        
        
    }
    
}
