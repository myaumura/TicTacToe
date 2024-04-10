//
//  SceneDelegate.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 06.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationVC: UINavigationController?
    var vc: UIViewController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let vc = StartScreenAssembly.build()
        self.vc = vc
        navigationVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
        self.window = window
    }
}

