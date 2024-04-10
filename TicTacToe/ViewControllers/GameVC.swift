//
//  ViewController.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 06.04.2024.
//

import UIKit

final class GameVC: UIViewController {
    
    private let gameState = GameState()
    private let gameView = GameMainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        gameState.delegate = self
        gameView.configure(with: gameState)
        addSubviews()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentChooseSideAlert(title: "Choose the side!", message: "You need to peek the side!", firstButtonTitle: "X", secondButtonTitle: "O")
    }
    
    private func addSubviews() {
        view.addSubview(gameView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async { [weak self] in
            let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.delegate = self
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self?.present(alertVC, animated: true)
        }
    }
    
    private func presentChooseSideAlert(title: String, message: String, firstButtonTitle: String, secondButtonTitle: String) {
        DispatchQueue.main.async { [weak self] in
            let alertVC = PickSideAlertVC(title: title, message: message, leftButtonTitle: firstButtonTitle, rightButtonTitle: secondButtonTitle)
            alertVC.delegate = self
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self?.present(alertVC, animated: true)
        }
    }
}

// MARK: - PickSideAlertVCDelegate

extension GameVC: PickSideAlertVCDelegate {
    func startWithX() {
        gameState.startGameWithX()
        gameView.textTurn()
    }
    
    func startWithO() {
        gameState.startGameWithO()
        gameView.textTurn()
    }
}

// MARK: - GameStateDelegate

extension GameVC: GameStateDelegate {
    func reloadData() {
        gameState.resetBoard()
        gameView.reloadCollection()
    }
}

extension GameVC: AlertVCDelegate {
    func showAlert(title:String, alertMessage: String) {
        presentAlertOnMainThread(title: title, message: alertMessage, buttonTitle: "Let's play a new game!")
    }
}
