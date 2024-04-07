//
//  GameState.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 06.04.2024.
//

import Foundation

protocol GameStateDelegate: AnyObject {
    func showAlert(alertMessage: String)
}

final class GameState {
    
    weak var delegate: GameStateDelegate?
    
    public var board = [[Cell]]()
    public var turn = Tile.Cross
    var noughtScore = 0
    var crossScore = 0
    var showAlert = false
    var alertMessage = "Draw"
    
    init () {
        resetBoard()
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
            showAlert(message: alertMessage)
        } else {
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
        
        if checkDraw() {
            alertMessage = "Draw"
            showAlert(message: alertMessage)
        }
    }
    
    func showAlert(message: String) {
        delegate?.showAlert(alertMessage: message)
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
            }
        }
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
    }
}
