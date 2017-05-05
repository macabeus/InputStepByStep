//
//  CellConfigInput.swift
//  InputStepByStep
//
//  Created by Bruno Macabeus Aquino on 03/05/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit
import Cartography

class CellConfigInput: UICollectionViewCell {
    
    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var underlineView: DashedView!
    var inputName: String?
    var configTitle: String?
    var myCellDivisin: CellConfigDivision?
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        self.layer.shadowColor = UIColor.white.cgColor
        
        if self === context.previouslyFocusedItem {
            
            coordinator.addCoordinatedAnimations({
                self.layer.shadowOpacity = 0.0
            }, completion: {
                
            })
        } else if self === context.nextFocusedItem {
            
            coordinator.addCoordinatedAnimations({
                self.layer.shadowOpacity = 0.6
            }, completion: {
                
            })
        }
    }
    
    func updateWidthUnderline() {
        removeConstraints(constraints)
        
        labelField.sizeToFit()
        
        constrain(labelField, underlineView) { field, underline in
            field.top == field.superview!.top
            field.left == field.superview!.left
            field.height == field.height
            field.width == field.width
            
            underline.top == field.bottom
            underline.left == field.left
            underline.width == 230
            underline.height == 1
        }
    }
    
}
