//
//  ViewController.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 06.04.2024.
//

import UIKit

class ViewController: UIViewController, GameStateDelegate {
    
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
    
    private func addSubviews() {
        view.addSubview(gameView)
    }
    
    func showAlert(alertMessage: String) {
        self.presentAlertOnMainThread(title: "", message: alertMessage, buttonTitle: "OK")
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

