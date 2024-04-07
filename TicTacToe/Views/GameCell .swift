//
//  GameCell .swift
//  TicTacToe
//
//  Created by Kirill Gusev on 07.04.2024.
//

import UIKit

final class GameCell: UICollectionViewCell {
    
    static let identifier = "GameCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func configure(with gameState: GameState, index: Int) {
        let row = index / 3
        let column = index % 3
        gameState.placeTile(row: row, column: column)
        label.text = gameState.board[row][column].displayTile()
        label.textColor = gameState.board[row][column].tileColor()
    }
    
    override func prepareForReuse() {
        label.text = nil
        label.textColor = .black
    }
}
