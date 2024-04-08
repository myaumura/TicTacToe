//
//  Router.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 08.04.2024.
//

import UIKit

final class Router {
    private var controller: UIViewController?
    private var targetController: UIViewController?
    
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }
    
    func setTargetController(controller: UIViewController) {
        self.targetController = controller
    }
    
    func next() {
        guard let targetController = targetController else { return }
        controller?.navigationController?.pushViewController(targetController, animated: true)
    }
}
