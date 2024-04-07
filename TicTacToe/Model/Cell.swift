//
//  Cell.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 06.04.2024.
//

import UIKit

struct Cell {
    var tile: Tile?
    
    func displayTile() -> String {
        switch tile {
        case .Nought:
            return "O"
        case .Cross:
            return "X"
        default:
            return ""
        }
    }
    
    func tileColor() -> UIColor {
        switch tile {
        case .Nought:
            return UIColor.red
        case .Cross:
            return UIColor.black
        default:
            return UIColor.black
        }
    }
}

enum Tile {
    case Nought
    case Cross
    case Empty
}
