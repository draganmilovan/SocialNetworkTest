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
        
        populateMembersFriendsFriends(for: member)
        
    }
    
    //
    // Method for populating membersFriendsFriends Array
    //
    func populateMembersFriendsFriends(for member: MemberDataModel) {
        
        var all: [Int] = []
        var ff: [Int] = []
        
        let _ = membersFriends.compactMap {
            all.append(contentsOf: $0.friends)
        }
        
        let _ = all.compactMap {
            if ($0 != member.id), (!ff.contains($0)) {
                ff.append($0)
            }
        }
        
        let _ = member.friends.compactMap {
            for (index, element) in ff.enumerated() {
                if element == $0 {
                    ff.remove(at: index)
                }
            }
        }
        
        let _ = ff.compactMap {
            let id = $0
            let _ = members.compactMap {
                if $0.id == id {
                    membersFriendsFriends.append($0)
                }
            }
        }
        
        populateMembersSuggestedFriends(for: member)
        
    }
    
    //
    // Method for populating membersSuggestedFriends Array
    //
    func populateMembersSuggestedFriends(for member: MemberDataModel) {
        
        var all: [Int] = []
        var ff: [Int] = []
        var sf: [Int] = []
        
        let _ = membersFriends.compactMap {
            all.append(contentsOf: $0.friends)
        }
        
        let _ = all.compactMap {
            if ($0 != member.id) {
                ff.append($0)
            }
        }
        
        let _ = member.friends.compactMap {
            for (index, element) in ff.enumerated() {
                if element == $0 {
                    ff.remove(at: index)
                }
            }
        }
        
        sf = ff.duplicates()
        
        let _ = sf.compactMap {
            let id = $0
            let _ = members.compactMap {
                if $0.id == id {
                    membersSuggestedFriends.append($0)
                }
            }
        }
        
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
