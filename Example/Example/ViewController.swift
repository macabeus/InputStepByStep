//
//  ViewController.swift
//  Example
//
//  Created by Bruno Macabeus Aquino on 03/05/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit
import InputStepByStep

class ViewController: UIViewController, InputStepByStepProtocol {
    
    @IBOutlet weak var container: UIView!
    var containerStepByStep: InputStepByStep?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    var configList: [CellCreateGrid] = [
        .name("Login", required: true),
        .input(name: "user", label: "User"),
        .input(name: "password", label: "Password"),
        .input(name: "email", label: "E-Mail"),
        
        .name("Personal infos", required: false),
        .input(name: "firtname", label: "Your first name"),
        .input(name: "lastname", label: "Your last name"),
        
        .name("Social network", required: false),
        .input(name: "github", label: "Github"),
        .input(name: "facebook", label: "Facebook"),
        .input(name: "linkedin", label: "Linkedin"),
        .input(name: "stackoverflow", label: "Stackoverflow"),
        
        .finish()
    ]
    
    func cellFinishAction(inputValues: [String: [String: String]]) {
        print("do something...")
        
        if let user = inputValues["Login"]?["user"],
            let password = inputValues["Login"]?["password"],
            let email = inputValues["Login"]?["email"] {
            
            print("create account with login \(user), password \(password) and email \(email)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueInputStepyBtStep" {
            self.containerStepByStep = (segue.destination as! InputStepByStep)
            self.containerStepByStep!.delegate = self
        }
    }
}
