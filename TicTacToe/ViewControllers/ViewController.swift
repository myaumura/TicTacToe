//
//  ViewController.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 06.04.2024.
//

import UIKit

class ViewController: UIViewController, GameStateDelegate, AlertVCDelegate {
    
    private var gameState = GameState()
    private var gameView = GameMainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        gameState.delegate = self
        gameView.configure(with: gameState)
        addSubviews()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        presentAlertOnMainThread(title: "Choose the side!", message: "You need to peek the side!", firstButtonTitle: "X", secondButtonTitle: "O")
    }
    
    private func addSubviews() {
        view.addSubview(gameView)
    }
    
    func showAlert(title:String, alertMessage: String) {
        self.presentAlertOnMainThread(title: title, message: alertMessage, buttonTitle: "Let's play a new game!")
    }
    
    func reloadData() {
        gameState.resetBoard()
        gameView.reloadCollection()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.delegate = self
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentAlertOnMainThread(title: String, message: String, firstButtonTitle: String, secondButtonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = PickSideAlertVC(title: title, message: message, firstButtonTitle: firstButtonTitle, secondButtonTitle: secondButtonTitle)
            alertVC.delegate = self
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}

// MARK: - PickSideAlertVCDelegate

extension ViewController: PickSideAlertVCDelegate {
    func startWithX() {
        gameState.startGameWithX()
        gameView.textTurn()
    }
    
    func startWithO() {
        gameState.startGameWithO()
        gameView.textTurn()
    }
}
