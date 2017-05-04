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
    @IBOutlet weak var labelResult: UILabel!
    
    var totalInputs = 0
    var totalInputsFilled = 0
    
    func startCell() {
        constrain(self.viewCircle, self.labelResult, self.viewDashed) { circle, label, dashed in
            circle.top == circle.superview!.top
            circle.centerX == circle.superview!.centerX
            circle.height == 32
            circle.width == 32
            
            label.center == circle.center
            
            dashed.top == circle.bottom + 3
            dashed.centerX == dashed.superview!.centerX
            dashed.bottom == dashed.superview!.bottom ~ UILayoutPriorityRequired
            dashed.width == 1
        }
    }
    
    func updateProress() {
        viewCircle.setupDash(totalInputsFilled: Double(totalInputsFilled), totalInputs: Double(totalInputs))
    }
    
    override var canBecomeFocused: Bool {
        return false
    }
    
}
