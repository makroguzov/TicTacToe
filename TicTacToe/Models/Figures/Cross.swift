//
//  Cross.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

@IBDesignable class Cross: Figure {
        
    override func updateShapeLayer() {
        super.updateShapeLayer()
        drawCross()
    }
    
    // MARK: - Draw methods
    
    private func drawCross() {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0.25 * bounds.width, y: 0.25 * bounds.height))
        path.addLine(to: CGPoint(x: 0.75 * bounds.width, y: 0.75 * bounds.height))
        path.move(to: CGPoint(x: 0.75 * bounds.width, y: 0.25 * bounds.height))
        path.addLine(to: CGPoint(x: 0.25 * bounds.width, y: 0.75 * bounds.height))
        path.close()
        
        shapeLayer.path = path.cgPath
    }
}

