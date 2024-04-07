//
//  GameState.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 06.04.2024.
//

import UIKit

protocol GameStateDelegate: AnyObject {
    func showAlert(title:String, alertMessage: String)
}

final class GameState {
    
    weak var delegate: GameStateDelegate?
    
    public var board = [[Cell]]()
    public var turn = Tile.Cross
    private var noughtScore = 0
    private var crossScore = 0
    private var drawScore = 0
    var alertMessage = "Draw"
    var firstTurnO = false
    
    init () {
        resetBoard()
    }
    
    func startGameWithX() {
        turn = Tile.Cross
    }
    
    func startGameWithO() {
        turn = Tile.Nought
        firstTurnO = true
    }
    
    func placeTile(row: Int, column: Int) {
        
        if(board[row][column].tile != Tile.Empty) {
            return
        }
        
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        
        if checkVictory() {
            if turn == Tile.Cross {
                crossScore += 1
            } else {
                noughtScore += 1
            }
            let winner = turn == Tile.Cross ? "Crosses" : "Noughts"
            alertMessage = winner + " Win!"
            delegate?.showAlert(title: "Win!", alertMessage: alertMessage)
        } else {
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
        
        if checkDraw() {
            alertMessage = "It's a Draw"
            delegate?.showAlert(title: "Draw!", alertMessage: alertMessage)
        }
    }
    
    func turnText() -> String {
        return turn == Tile.Cross ? "Turn: X" : "Turn: O"
    }
    
    func turnColor() -> UIColor {
        return turn == Tile.Cross ? UIColor.black : UIColor.red
    }
    
    func gameCrossScore() -> Int {
        return crossScore
    }
    
    func gameNoughtScore() -> Int {
        return noughtScore
    }
    
    func gameDrawScore() -> Int {
        return drawScore
    }
    
    func checkVictory() -> Bool {
        
        if isTurnTile(0, 0) && isTurnTile(1, 0) && isTurnTile(2, 0) {
            return true
        }
        
        if isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1) {
            return true
        }
        
        if isTurnTile(0, 2) && isTurnTile(1, 2) && isTurnTile(2, 2) {
            return true
        }
        
        if isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2) {
            return true
        }
        
        if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1, 2) {
            return true
        }
        
        if isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2) {
            return true
        }
        
        if isTurnTile(0, 0) && isTurnTile(1, 1) && isTurnTile(2, 2) {
            return true
        }
        
        if isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2, 0) {
            return true
        }
        
        return false
    }
    
    func checkDraw() -> Bool {
        for row in board {
            for cell in row {
                if cell.tile == Tile.Empty {
                    return false
                }
                if checkVictory() {
                    return false
                }
            }
        }
        drawScore += 1
        return true
    }
    
    func isTurnTile(_ row: Int, _ column: Int) -> Bool {
        return board[row][column].tile == turn
    }
    
    func resetBoard() {
        var newBoard = [[Cell]]()
        
        for _ in 0...2 {
            var row = [Cell]()
            
            for _ in 0...2 {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
        if firstTurnO == true {
            turn = Tile.Nought
        } else {
            turn = Tile.Cross
        }
    }
}
