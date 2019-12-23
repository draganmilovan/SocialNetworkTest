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


//extension MemberDataModel: Hashable {
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    
//    static func ==(m1: MemberDataModel, m2: MemberDataModel) -> Bool {
//        return m1.id == m2.id
//    }
//    
//}
