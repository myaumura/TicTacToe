//
//  ViewController.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 06.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private var gameView = GameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(gameView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 75),
            gameView.heightAnchor.constraint(equalToConstant: 375),
            gameView.widthAnchor.constraint(equalToConstant: 375)
        ])
    }
}

