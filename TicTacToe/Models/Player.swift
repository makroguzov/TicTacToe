//
//  Player.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import Foundation

final class Player {
    
    // MARK: Properties
    
    private let drawStrategy: DrawStrategy
    private(set) var name: String
        
    // MARK: - init
    
    init(name: String, drawStrategy: DrawStrategy) {
        self.name = name
        self.drawStrategy = drawStrategy
    }
    
    // MARK: - Methods
    
    func draw(inField gameField: GameField, at indexPath: IndexPath) {
        gameField.draw(strategy: drawStrategy, at: indexPath)
    }
    
    func isMy(figure: Figure?) -> Bool {
        if let figure = figure {
            return drawStrategy.isMy(figure: figure)
        } else {
            return false
        }
    }
}

