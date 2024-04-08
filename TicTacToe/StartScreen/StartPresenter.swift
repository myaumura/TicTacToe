//
//  StartPresenter.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 08.04.2024.
//

import UIKit

protocol StartPresenterProtocol {
    func loadView(controller: StartGameVC, view: StartGameView)
}

final class StartPresenter {
    private let router: Router
    private weak var controller: StartGameVC?
    private weak var view: StartGameViewProtocol?
    
    init(router: Router) {
        self.router = router
    }
}

private extension StartPresenter {
    func goToGame() {
        self.router.next()
    }
    
    func setHandlers() {
        self.view?.startTheGame = { [weak self] in
            self?.goToGame()
        }
    }
}

extension StartPresenter: StartPresenterProtocol {
    func loadView(controller: StartGameVC, view: StartGameView) {
        self.controller = controller
        self.view = view
        self.setHandlers()
    }
}

