//
//  DrawStrategysFactory.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import Foundation

class DrawStrategysFactory {
    enum Figure {
        case cross, zero
    }
    
    func getStrategy(figure: Figure) -> DrawStrategy {
        switch figure {
        case .cross:
            return DrawСross()
        case .zero:
            return DrawZero()
        }
    }
}
