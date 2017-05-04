//
//  DashedView.swift
//  InputStepByStep
//
//  Created by Bruno Macabeus Aquino on 04/05/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

class DashedView: UIView {
    
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
        
        self.setupDash()
    }
    
    private func setupDash() {
        self.alpha = 0.2
        self.backgroundColor = .clear
        self.clipsToBounds = true
        
        guard let shapeLayer = self.layer as? CAShapeLayer else {
            preconditionFailure()
        }
        
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [1, 1]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 1).cgPath
    }
    
}
