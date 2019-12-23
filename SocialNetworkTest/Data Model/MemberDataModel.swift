//
//  MemberDataModel.swift
//  SocialNetworkTest
//
//  Created by Dragan Milovanovic on 12/19/19.
//  Copyright © 2019 Dragan Milovanovic. All rights reserved.
//

import Foundation


struct MemberDataModel: Codable {
    
    let id: Int
    let firstName: String
    let surname: String?
    let age: Int?
    let gender: String?
    var friends: [Int] = []
    
}
