//
//  DrawStrategysFactory.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import Foundation

final class DrawStrategysFactory {
    
    enum Errors: Error {
        case InvalidFigureId
    }
    
    enum Figure {
        case cross, zero
    }
    
    func getStrategy(figureId: Int) throws -> DrawStrategy {
        switch figureId {
        case 0:
            return DrawСross()
        case 1:
            return DrawZero()
        default:
            throw Errors.InvalidFigureId
        }
    }
}
