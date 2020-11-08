//
//  Zero.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

@IBDesignable class Zero: Figure {
    
    
    override func draw(_ rect: CGRect) {
        drawCircle()
    }
    
    private func drawCircle() {
        let halfSize: CGFloat = min(bounds.size.width/2, bounds.size.height/2)
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: halfSize, y: halfSize),
            radius: halfSize - (lineWidth / 2),
            startAngle: 0,
            endAngle: CGFloat.pi * 2,
            clockwise: true
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        
        layer.addSublayer(shapeLayer)
        layer.masksToBounds = true
    }

}
