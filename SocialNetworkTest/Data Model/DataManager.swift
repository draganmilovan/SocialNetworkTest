//
//  DataManager.swift
//  SocialNetworkTest
//
//  Created by Dragan Milovanovic on 12/19/19.
//  Copyright © 2019 Dragan Milovanovic. All rights reserved.
//

import Foundation


final class DataManager {
    
    var members: [MemberDataModel] = []
    
    
    init() {
        populateMembers()
    }
    
}



// MARK:- Items Data Manager private methods
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
