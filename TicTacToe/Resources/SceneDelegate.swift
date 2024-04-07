//
//  SceneDelegate.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 06.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let vc = ViewController()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        window.rootViewController = vc
        self.window = window
    }
}

