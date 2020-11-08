//
//  GameField.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import Foundation

class GameField {
    
    private var field: [[Figure?]]
    
    init(size: Int) {
        field = (0 ..< size).map{ _ in (0 ..< size).map { _ in nil } }
    }
    
    func getFigure(for indexPath: IndexPath) -> Figure? {
        let row = indexPath.section
        let column = indexPath.row
        
        return field[row][column]
    }
    
    func draw(_ figure: Figure, in indexPath: IndexPath) {
        let row = indexPath.section
        let column = indexPath.row

        field[row][column] = figure
    }
}
