//
//  DrawStrategy.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

protocol DrawStrategy: AnyObject {
    func drawFigure(frame: CGRect) -> Figure
}



final class DrawСross: DrawStrategy {
    func drawFigure(frame: CGRect) -> Figure {
        return Cross(frame: frame)
    }
}



final class DrawZero: DrawStrategy {
    func drawFigure(frame: CGRect) -> Figure {
        return Zero(frame: frame)
    }
}
