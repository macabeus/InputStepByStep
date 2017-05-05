[![Version](https://img.shields.io/cocoapods/v/InputStepByStep.svg?style=flat)](http://cocoapods.org/pods/InputStepByStep)
[![License](https://img.shields.io/cocoapods/l/InputStepByStep.svg?style=flat)](http://cocoapods.org/pods/InputStepByStep)
[![Platform](https://img.shields.io/cocoapods/p/InputStepByStep.svg?style=flat)](http://cocoapods.org/pods/InputStepByStep)

# InputStepByStep
📝 A input view for tvOS, useful for testing purposes.

*"Hey, but it is horrible to enter input in AppleTV!"*<br>
Yes, I know, but in some cases it is useful for testing, when you are using simulator or testing in physical device with iPhone.

![](http://i.imgur.com/wKI9jI8.png)

You can download this repository and see this example app.

# How to use

## Install
In `Podfile` add
```
pod 'InputStepByStep'
```

and use `pod install`.

## Setup

### Storyboard
![](http://i.imgur.com/N5djsPz.png)

1. Create a *Container View*
2. Change the *View Controller* for  *Collection View Controller*
3. Set `InputStepByStep` as a custom class

### Set fields

Your controller that will manager a `InputStepByStep` need subscriber the protocol `InputStepByStepProtocol`

Minimal example:

```swift
class ViewController: UIViewController, InputStepByStepProtocol {
    
    @IBOutlet weak var container: UIView!
    var containerStepByStep: InputStepByStep?
        
    var configList: [CellCreateGrid] = [ // set the inputs
        .name("Login"),
        .input(name: "user", label: "User"),
        .input(name: "password", label: "Password"),
        .input(name: "email", label: "E-Mail"),
        
        .name("Personal infos"),
        .input(name: "firtname", label: "Your first name"),
        .input(name: "lastname", label: "Your last name"),
        
        .finish() // you need set the ".finish" at the end of "configList"
    ]
    
    func cellFinishAction(inputValues: [String: [String: String]]) { // when the user click in green button
        if let user = inputValues["Login"]?["user"],
            let password = inputValues["Login"]?["password"],
            let email = inputValues["Login"]?["email"] {
            
            print("create account with login \(user), password \(password) and email \(email)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueInputStepyBtStep" {
            self.containerStepByStep = (segue.destination as! InputStepByStep)
            self.containerStepByStep!.delegate = self // set a delegate where
        }
    }
}
```

The `configList` is a list of inputs that `InputStepByStep` will show.<br>
You use `.name(String)` to create a division and `.input(name: String, label: String` to create a input. And, at the end, you need add `.finish()` to create a green button.

The function `cellFinishAction(inputValues:)` is called when the green button is clicked.<br>
The parameters in `inputValues` is a dictionary with key as the name of division ("Login" or "Personal infos" in example) and value is another dictionary, with key as the name of input ("email", for example) and the value is the value setted by user.
