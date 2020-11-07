//
//  Player.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import Foundation

class Player {
    
    private let drawStrategy: DrawStrategy
    let name: String
    
    init(name: String, drawStrategy: DrawStrategy) {
        self.name = name
        self.drawStrategy = drawStrategy
    }
    
    func draw() -> Figure {
        return drawStrategy.drawFigure()
    }
}

