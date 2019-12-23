//
//  FriendsCell.swift
//  SocialNetworkTest
//
//  Created by Dragan Milovanovic on 12/23/19.
//  Copyright © 2019 Dragan Milovanovic. All rights reserved.
//

import UIKit

class FriendsCell: UICollectionViewCell {
    
    // Data source
    var member: MemberDataModel? {
        didSet {
            guard let member = member else { return }
            populate(with: member)
        }
    }
    
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var lastNameLabel: UILabel!
    @IBOutlet fileprivate weak var ageLabel: UILabel!
    @IBOutlet fileprivate weak var sexLabel: UILabel!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cleanCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cleanCell()
    }
    
    
    //
    // Method for cleaning datas for UI
    //
    private func cleanCell() {
        
        nameLabel.text = nil
        lastNameLabel.text = nil
        ageLabel.text = nil
        sexLabel.text = nil
    }
    
    
    //
    // Method for populating Cell
    //
    private func populate(with member: MemberDataModel) {
        
        nameLabel.text = member.firstName
        
        if let ln = member.surname {
            lastNameLabel.text = ln
        } else {
            lastNameLabel.text = "--"
        }
        
        if let age = member.age {
            ageLabel.text = String(age)
        } else {
            ageLabel.text = "--"
        }
        
        if let sex = member.gender {
            sexLabel.text =  sex
        } else {
            sexLabel.text = "--"
        }
        
    }
    
    
}
