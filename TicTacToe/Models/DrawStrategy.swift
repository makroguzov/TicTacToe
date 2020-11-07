//
//  DrawStrategy.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import Foundation

protocol DrawStrategy: AnyObject {
    func drawFigure() -> Figure
}

class DrawСross: DrawStrategy {
    func drawFigure() -> Figure {
        return Cross()
    }
}

class DrawZero: DrawStrategy {
    func drawFigure() -> Figure {
        return Zero()
    }
}
