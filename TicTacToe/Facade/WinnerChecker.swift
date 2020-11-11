//
//  WinnerChecker.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 11.11.2020.
//

import Foundation

public final class WinnerChecker {
    
    // MARK: - Properties
    
    private let gameField: GameField
    private var chekFigure: (Figure?) -> Bool = {_ in
        return false
    }
    // MARK: - Init
    
    init(gameField: GameField) {
        self.gameField = gameField
    }
    
    // MARK: - Public Methods
    
    func isPlayerWin(lastMove: IndexPath, player: Player) -> Bool {
        let row = lastMove.section
        let column = lastMove.row
        
        chekFigure = player.isMy(figure:)
        
        return checkVirtical(row: row) ||
            checkHorizontal(column: column) ||
            checkDiagonal(row: row, column: column)
    }
    
    // MARK: - Private Methods
    
    private func checkHorizontal(column: Int) -> Bool {
        let column = gameField.getColumn(column)
        return check(figures: column)
    }
    
    private func checkVirtical(row: Int) -> Bool {
        let row = gameField.getRow(row)
        return check(figures: row)
    }
    
    private func checkDiagonal(row: Int, column: Int) -> Bool {
        guard row != column else {
            return false
        }
        
        let (leftDaig, rightDiag) = gameField.getDiagonals()
        return check(figures: leftDaig) || check(figures: rightDiag)
    }
    
    private func check(figures: [Figure?]) -> Bool {
        for figure in figures {
            if !chekFigure(figure) {
                return false
            }
        }
        return true
    }
}

