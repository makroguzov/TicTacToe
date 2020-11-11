//
//  Figure.swift
//  TicTacToe
//
//  Created by Валерий Макрогузов on 07.11.2020.
//

import UIKit

@IBDesignable class Figure: UIView {
   
    // MARK: - IBInspectable properties
    
    @IBInspectable var lineWidth: CGFloat = 10
    @IBInspectable var strokeColor: UIColor = .white
    @IBInspectable var fillColor: UIColor = .clear


    // MARK: - Shape layer
    
    private(set) lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = strokeColor.cgColor
        self.layer.addSublayer(shapeLayer)
        return shapeLayer
    }()

    
    // MARK: - UIView
        
    public override var frame: CGRect {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    public override var bounds: CGRect {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    public final override func layoutSubviews() {
        super.layoutSubviews()
        updateShapeLayer()
    }
    
    // MARK: - Methods
    
    public func animateIn(duration: TimeInterval = 0.5,
                          completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0.0
        animation.toValue = 1.0
        shapeLayer.add(animation, forKey: nil)
        CATransaction.commit()
    }
    
    public func animateOut(duration: TimeInterval = 0.5,
                           completion: @escaping () -> Void) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.fromValue = 1.0
        animation.toValue = 0.0
        shapeLayer.add(animation, forKey: nil)
        CATransaction.commit()
    }
    
    // MARK: - Template methods
    
    func updateShapeLayer() {

    }
}
