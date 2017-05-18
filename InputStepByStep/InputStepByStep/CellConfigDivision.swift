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
    
    @IBOutlet weak var viewCircle: CirclePercentView!
    @IBOutlet weak var viewDashed: UIView!
    
    var totalInputs = 0
    var totalInputsFilled = 0
    
    func startCell(required: Bool) {
        if required {
            viewCircle.percentColor = #colorLiteral(red: 1, green: 0.2509803922, blue: 0.4784313725, alpha: 1)
            viewCircle.percentBackgroundColor = #colorLiteral(red: 1, green: 0.250980407, blue: 0.4784313738, alpha: 0.5)
            viewCircle.backgroundOpacity = 0.8
            viewCircle.percentFullColor = #colorLiteral(red: 0.7215686275, green: 0.3960784314, blue: 0.8235294118, alpha: 1)
        }
        
        constrain(self.viewCircle, self.viewDashed) { circle, dashed in
            circle.top == circle.superview!.top
            circle.centerX == circle.superview!.centerX
            circle.height == 32
            circle.width == 32
            
            dashed.top == circle.bottom + 3
            dashed.centerX == dashed.superview!.centerX
            dashed.bottom == dashed.superview!.bottom ~ UILayoutPriorityRequired
            dashed.width == 1
        }
        
        viewCircle.setupDash(totalInputsFilled: 0, totalInputs: 1)
    }
    
    func updateProress() {
        viewCircle.setupDash(totalInputsFilled: Double(totalInputsFilled), totalInputs: Double(totalInputs))
    }
    
    override var canBecomeFocused: Bool {
        return false
    }
    
}
