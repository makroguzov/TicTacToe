//
//  Cross.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

@IBDesignable class Cross: Figure {
    
    override func draw(_ rect: CGRect) {
        drawCross()
    }
    
    private func drawCross() {
        drawLine(from: CGPoint(x: 0, y: 0),
                 to: CGPoint(x: frame.maxX, y: frame.maxY)
        )
        
        drawLine(from: CGPoint(x: frame.maxY, y: 0),
                 to: CGPoint(x: 0, y: frame.maxY)
        )
    }
    
    private func drawLine(from startPoint: CGPoint, to endPoint: CGPoint) {
        let line = UIBezierPath()
        
        line.move(to: startPoint)
        line.addLine(to: endPoint)
        line.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = line.cgPath
        
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        
        layer.addSublayer(shapeLayer)
    }
}

