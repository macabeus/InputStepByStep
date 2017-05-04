//
//  CellConfigInput.swift
//  InputStepByStep
//
//  Created by Bruno Macabeus Aquino on 03/05/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

class CellConfigInput: UICollectionViewCell {
    
    @IBOutlet weak var labelField: UILabel!
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
}
