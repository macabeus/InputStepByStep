//
//  CirclePercentView.swift
//  InputStepByStep
//
//  Created by Bruno Macabeus Aquino on 04/05/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

class CirclePercentView: UIView {
    
    var shapeLayerBackground = CAShapeLayer()
    var shapeLayer = CAShapeLayer()
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupDash(totalInputsFilled: 0, totalInputs: 1)
    }
    
    func setupDash(totalInputsFilled: Double, totalInputs: Double) {
        let circleBackground = UIBezierPath(
            arcCenter: CGPoint(x: frame.width / 2, y: (frame.height / 2) + 2),
            radius: frame.height / 2,
            startAngle: 0,
            endAngle: CGFloat(Double.pi * 2),
            clockwise: true
        )
        
        shapeLayerBackground.path = circleBackground.cgPath
        shapeLayerBackground.opacity = 0.2
        shapeLayerBackground.fillColor = #colorLiteral(red: 0.7215686275, green: 0.3960784314, blue: 0.8235294118, alpha: 0.5).cgColor
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: frame.width / 2, y: (frame.height / 2) + 2),
            radius: frame.height / 2,
            startAngle: 0,
            endAngle: CGFloat((Double.pi * 2) * (totalInputsFilled / totalInputs)),
            clockwise: true
        )
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0).cgColor
        
        shapeLayer.strokeColor = #colorLiteral(red: 0.7215686275, green: 0.3960784314, blue: 0.8235294118, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        
        self.layer.addSublayer(shapeLayerBackground)
        self.layer.addSublayer(shapeLayer)
    }
    
}
