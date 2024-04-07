//
//  ViewController.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 06.04.2024.
//

import UIKit

class ViewController: UIViewController, GameStateDelegate {
    
    private var gameState = GameState()
    private var gameView = GameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        gameState.delegate = self
        gameView.configure(with: gameState)
        view.addSubview(gameView)
        setupConstraints()
    }
    
    func showAlert(alertMessage: String) {
        self.presentAlertOnMainThread(title: "", message: alertMessage, buttonTitle: "OK")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 75),
            gameView.heightAnchor.constraint(equalToConstant: 375),
            gameView.widthAnchor.constraint(equalToConstant: 375)
        ])
    }
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default)
            alertVC.addAction(okButton)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.dismiss(animated: true) { [weak self] in
                self?.gameState.resetBoard()
                self?.gameView.reloadCollection()
            }
            self.present(alertVC, animated: true)
        }
    }
}

