//
//  SceneDelegate.swift
//  SocialNetworkTest
//
//  Created by Dragan Milovanovic on 12/19/19.
//  Copyright © 2019 Dragan Milovanovic. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var dataManager: DataManager?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        configureDataManager()
        
        guard let nc = window?.rootViewController as? UINavigationController else {
            fatalError("Missing Initial Controller!")
        }
        guard let vc = nc.topViewController as? SocialNetworkController else {
            fatalError("Missing SocialNetworkController!")
        }
        
        vc.dataManager = dataManager
    }
    
}



// MARK:- SceneDelegate private method
fileprivate extension SceneDelegate {
    
    func configureDataManager() {
        
        dataManager = DataManager()
    }
    
}
