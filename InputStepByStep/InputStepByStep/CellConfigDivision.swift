//
//  CellConfigDivision.swift
//  InputStepByStep
//
//  Created by Bruno Macabeus Aquino on 03/05/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit
import Cartography

class CellConfigDivision: UICollectionViewCell {
    
    @IBOutlet weak var viewCircle: UIView!
    @IBOutlet weak var viewDashed: UIView!
    @IBOutlet weak var labelResult: UILabel!
    
    func startCell() {
        viewCircle.asCircle()
        viewDashed.alpha = 0.2
        viewDashed.backgroundColor = .clear
        
        viewDashed.updateConstraints()
        viewDashed.setNeedsLayout()
        viewDashed.layoutIfNeeded()
        
        constrain(self.viewCircle, self.labelResult, self.viewDashed) { circle, label, dashed in
            circle.top == circle.superview!.top
            circle.centerX == circle.superview!.centerX
            circle.height == 32
            circle.width == 32
            
            label.center == circle.center
            
            dashed.top == circle.bottom
            dashed.centerX == dashed.superview!.centerX
            dashed.height == self.frame.height - viewCircle.frame.height
            //dashed.bottom == dashed.superview!.bottom
            dashed.width == 1
        }
        
        // we need call "setNeedsLayout" and "layoutIfNeeded": https://github.com/robb/Cartography/issues/258
        viewDashed.setNeedsLayout()
        viewDashed.layoutIfNeeded()
        
        viewDashed.addDashedBorder()
    }
    
    override var canBecomeFocused: Bool {
        return false
    }
    
}
