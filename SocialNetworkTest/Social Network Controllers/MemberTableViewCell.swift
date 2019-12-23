//
//  MemberTableViewCell.swift
//  SocialNetworkTest
//
//  Created by Dragan Milovanovic on 12/22/19.
//  Copyright © 2019 Dragan Milovanovic. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    
    // Data source
    var member: MemberDataModel? {
        didSet {
            guard let member = member else { return }
            populate(with: member)
        }
    }

    @IBOutlet fileprivate weak var memberInfoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cleanCell()
    }
    
    override func prepareForReuse() {
        cleanCell()
    }

    
    //
    // Method for populating Cell
    //
    fileprivate func populate(with member: MemberDataModel) {
        var name: String = ""
        var surName: String = ""
        var age: String = ""
        var sex: String = ""
        
        name = member.firstName + " "
        
        if let lastName = member.surname {
            surName = lastName + "   "
        }
        
        if let a = member.age {
            age = "(" + String(a) + ")" + "   "
        }
        
        if let gen = member.gender {
            sex = gen
        }
        
        memberInfoLabel.text = name + surName + age + sex
    }
    
    //
    // Method for cleaning datas for UI
    //
    fileprivate func cleanCell() {
        memberInfoLabel.text = nil
    }
    
}
