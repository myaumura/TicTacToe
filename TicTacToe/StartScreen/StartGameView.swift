//
//  StartGameView.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 08.04.2024.
//

import UIKit

protocol StartGameViewProtocol: UIView {
    var startTheGame: (() -> Void)? { get set }
    func setupButton()
}

final class StartGameView: UIView {
    
    var startTheGame: (() -> Void)?
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
        button.setTitle("Start Game", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func startGame() {
        self.startTheGame?()
    }
}

extension StartGameView: StartGameViewProtocol {
    func setupButton() {
        addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
