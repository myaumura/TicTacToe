//
//  GameState.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 06.04.2024.
//

import Foundation

final class GameState {
    
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
        } else {
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
    }
    
    func checkVictory() -> Bool {
       return false
    }
    
    func isTurnTile(row: Int, column: Int) -> Bool {
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
