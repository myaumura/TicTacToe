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
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.text = "Tic Tac Toe"
        label.textAlignment = .center
        return label
    }()
    
    private let imageView = UIImageView(image: UIImage(named: "game_logo"))
    
    private let actionButton = AlertButton(backgroundColor: .systemPink, title: "Start Game")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setupConstraints()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func startGame() {
        self.startTheGame?()
    }
}

// MARK: StartGameViewProtocol

extension StartGameView: StartGameViewProtocol {
    func setupButton() {
        actionButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }
}

private extension StartGameView {
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 240),
            imageView.widthAnchor.constraint(equalToConstant: 240),
            
            actionButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            actionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
