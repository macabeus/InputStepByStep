//
//  CirclePercentView.swift
//  InputStepByStep
//
//  Created by Bruno Macabeus Aquino on 04/05/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

class CirclePercentView: UIView {
    
    var percentColor = #colorLiteral(red: 0.7215686275, green: 0.3960784314, blue: 0.8235294118, alpha: 1)
    var percentBackgroundColor = #colorLiteral(red: 0.7215686275, green: 0.3960784314, blue: 0.8235294118, alpha: 0.5)
    var backgroundOpacity: Float = 0.2
    var percentFullColor = #colorLiteral(red: 0.7215686275, green: 0.3960784314, blue: 0.8235294118, alpha: 1)
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupDash(totalInputsFilled: Double, totalInputs: Double) {
        self.layer.sublayers = nil
        
        let circleBackground = UIBezierPath(
            arcCenter: CGPoint(x: frame.width / 2, y: (frame.height / 2) + 2),
            radius: frame.height / 2,
            startAngle: 0,
            endAngle: CGFloat(Double.pi * 2),
            clockwise: true
        )
        
        let shapeLayerBackground = CAShapeLayer()
        shapeLayerBackground.path = circleBackground.cgPath
        if totalInputsFilled == totalInputs {
            shapeLayerBackground.fillColor = percentFullColor.cgColor
            shapeLayerBackground.opacity = 1
        } else {
            shapeLayerBackground.fillColor = percentBackgroundColor.cgColor
            shapeLayerBackground.opacity = backgroundOpacity
        }
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: frame.width / 2, y: (frame.height / 2) + 2),
            radius: frame.height / 2,
            startAngle: 0,
            endAngle: CGFloat((Double.pi * 2) * (totalInputsFilled / totalInputs)),
            clockwise: true
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0).cgColor
        
        if totalInputsFilled == totalInputs {
            shapeLayer.strokeColor = percentFullColor.cgColor
        } else {
            shapeLayer.strokeColor = percentBackgroundColor.cgColor
        }
        shapeLayer.lineWidth = 4
        
        //
        self.layer.addSublayer(shapeLayerBackground)
        self.layer.addSublayer(shapeLayer)
        
        if totalInputsFilled == totalInputs {
            let label = CATextLayer()
            let fontSize = 18
            label.font = UIFont(name: "Helvetica", size: CGFloat(fontSize))
            label.fontSize = CGFloat(fontSize)
            label.alignmentMode = "center"
            label.frame.origin = CGPoint(x: 0, y: (bounds.height / 2) - CGFloat(fontSize / 2))
            label.frame.size = CGSize(width: bounds.width, height: bounds.height)
            label.string = "✓"
            label.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            label.isHidden = false
            
            self.layer.addSublayer(label)
        }
    }
    
}
