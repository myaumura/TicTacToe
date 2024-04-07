//
//  GameMainView.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 07.04.2024.
//

import UIKit

class GameMainView: UIView {

    private var gameState: GameState?
    
    private let turnLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Turn: X"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let scoreLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Cross: 0 Nought: 0 Draw: 0"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.identifier)
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
        setupCollectionView()
        setupConstraints()
        textTurn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with gameState: GameState) {
        self.gameState = gameState
    }
    
    private func setupSubviews() {
        addSubview(turnLabel)
        addSubview(scoreLabel)
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            turnLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            turnLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: turnLabel.bottomAnchor, constant: 20),
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 75),
            collectionView.heightAnchor.constraint(equalToConstant: 375),
            collectionView.widthAnchor.constraint(equalToConstant: 375)
        ])
    }
    
    func textTurn() {
        guard let turnText = gameState?.turnText() else { return }
        turnLabel.text = turnText
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
}

extension GameMainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as? GameCell else { return UICollectionViewCell() }
        cell.backgroundColor = .white
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 20) / 3, height: (collectionView.bounds.height - 20) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let gameState = gameState, let cell = collectionView.cellForItem(at: indexPath) as? GameCell else { return }
        cell.configure(with: gameState, index: indexPath.row)
        turnLabel.text = gameState.turnText()
        turnLabel.textColor = gameState.turnColor()
        scoreLabel.text = "Cross: " + "\(gameState.gameCrossScore()) " + "Noughts: " + "\(gameState.gameNoughtScore()) " + "Draw: " + "\(gameState.gameDrawScore())"
    }
}
