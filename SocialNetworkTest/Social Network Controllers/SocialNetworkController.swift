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
            print(self.dataManager!.members)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

