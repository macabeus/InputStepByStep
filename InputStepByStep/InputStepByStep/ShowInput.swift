//
//  ShowInput.swift
//  InputStepByStep
//
//  Created by Bruno Macabeus Aquino on 03/05/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

// This is a GREAT workaround!!! Fix it in future, please...
// https://stackoverflow.com/questions/42685096/how-to-show-input-screen-without-a-uitextfield

class ShowInput: UITextField, UITextFieldDelegate {
    
    var callback: ((String) -> Void)?
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(view: UIView) {
        view.addSubview(self)
        super.becomeFirstResponder()
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        callback?(textField.text!)
        textField.text = ""
        
        textField.removeFromSuperview()
    }
}
