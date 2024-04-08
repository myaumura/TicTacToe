//
//  StartScreenAssembly.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 08.04.2024.
//

import UIKit

final class StartScreenAssembly {
    static func build() -> UIViewController {
        let router = Router()
        
        let presenter = StartPresenter(router: router)
        
        let controller = StartGameVC(dependencies: .init(presenter: presenter))
        
        let targetController = ViewController()
        
        router.setRootController(controller: controller)
        router.setTargetController(controller: targetController)
        
        return controller
    }
}
