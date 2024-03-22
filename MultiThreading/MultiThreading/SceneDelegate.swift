//
//  SceneDelegate.swift
//  MultiThreading
//
//  Created by Vitaliy Iakushev on 18.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController(rootViewController: OperationsViewController())
        
        window?.rootViewController = navigationController
        
    }



}

