//
//  GameView.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 06.04.2024.
//

import UIKit

final class GameView: UIView {

    private var gameState = GameState()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = .black
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        addSubview(stackView)
        setupConstraints()
        createCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    private func createCells() {
        for row in 0...2 {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.spacing = 10
            stackView.addArrangedSubview(rowStackView)
            
            for column in 0...2 {
                let button = UIButton()
                button.backgroundColor = .white
                button.tag = row * 3 + column
                button.setTitle("", for: .normal)
                button.addTarget(self, action: #selector(cellTapped(_:)), for: .touchUpInside)
                rowStackView.addArrangedSubview(button)
                
                NSLayoutConstraint.activate([
                    button.widthAnchor.constraint(equalTo: button.heightAnchor)
                ])
            }
        }
    }
    
    @objc func cellTapped(_ sender: UIButton) {
        let row = sender.tag / 3
        let column = sender.tag % 3
        
        gameState.placeTile(row: row, column: column)
        sender.setTitle(gameState.board[row][column].displayTile(), for: .normal)
        sender.setTitleColor(gameState.board[row][column].tileColor(), for: .normal)
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    }
}
