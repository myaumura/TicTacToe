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
        self.vc = StartScreenAssembly.build()
        guard let vc = vc else { return }
        navigationVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
        self.window = window
    }
}

