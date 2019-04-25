//
//  ViewController.swift
//  FoodTracker
//
//  Created by Jordan Lewis on 4/19/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//

import UIKit

extension StringProtocol {
    var firstUppercased: String {
        return prefix(1).uppercased()  + dropFirst()
    }
    
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}

class NameViewController: UIViewController, UITextFieldDelegate{
    //MARK: Properties
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    var nameString : String = ""
    let alert = UIAlertController(title: "404", message: "No users found!", preferredStyle: .actionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.alpha = 0
        nameTextField.delegate = self
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1.0, animations: {
            self.startButton.alpha = 1.0
            self.startButton.isEnabled = true
            
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    @IBAction func saveUser(_ sender: UIButton) {
        let _name: String = nameTextField.text!
        nameString = _name
        nameString = nameString.firstCapitalized.trimmingCharacters(in: .whitespacesAndNewlines)
        if DataHandler.sharedManager.userNameExists(userName: nameString){
            DataHandler.sharedManager.activeUser = DataHandler.sharedManager.users[nameString]!
            performSegue(withIdentifier: "startCaptureSegue", sender:(Any).self)
        }
        else if(nameString != ""){
            let newUser : User = User(name: nameString, id: DataHandler.sharedManager.getUserID())
            DataHandler.sharedManager.addUser(user: newUser)
            DataHandler.sharedManager.setActiveUser(user: newUser)
            performSegue(withIdentifier: "startCaptureSegue", sender:(Any).self)
        }
    }
    @IBAction func loadScreen(_ sender: UIButton) {
        if DataHandler.sharedManager.users.count > 0{
         performSegue(withIdentifier: "loadSegue", sender:(Any).self)
        }
        else{
            self.present(alert, animated: true)
        }
    }
}

