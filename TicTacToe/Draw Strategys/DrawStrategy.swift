//
//  DrawStrategy.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

protocol DrawStrategy: AnyObject {
    func drawFigure(frame: CGRect) -> Figure
    func isMy(figure: Figure) -> Bool
}



final class DrawСross: DrawStrategy {
    func isMy(figure: Figure) -> Bool {
        return figure is Cross
    }
    
    func drawFigure(frame: CGRect) -> Figure {
        return Cross(frame: frame)
    }
}



final class DrawZero: DrawStrategy {
    func isMy(figure: Figure) -> Bool {
        return figure is Zero
    }
    
    func drawFigure(frame: CGRect) -> Figure {
        return Zero(frame: frame)
    }
}
