//
//  CellConfigTitle.swift
//  InputStepByStep
//
//  Created by Bruno Macabeus Aquino on 03/05/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

class CellConfigTitle: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    
    override var canBecomeFocused: Bool {
        return false
    }
    
}
