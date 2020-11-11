//
//  Zero.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

@IBDesignable final class Zero: Figure {
    
    override func updateShapeLayer() {
        super.updateShapeLayer()
        drawCircle()
    }
    
    // MARK: - Draw methods
    
    private func drawCircle() {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = 0.3 * min(bounds.width, bounds.height)
        shapeLayer.path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: 0,
            endAngle: CGFloat.pi * 2,
            clockwise: true
        ).cgPath
    }
}
