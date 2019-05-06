//
//  ViewController.swift
//  FoodTracker
//
//  Created by Jordan Lewis on 4/19/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//

import UIKit
import Foundation

class PasscodeViewController: UIViewController {
   
    @IBOutlet var circles: [UIButton]!
    
    var activeUser: User = UserData.sharedManager.getActiveUser()
    var dArray: [UIButton] = []
    var time: Timer = Timer.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
            timer in
            self.dataTimer(timer: timer)
        }
        
    }
    func dataTimer(timer:Timer) {
        DispatchQueue.global(qos: DispatchQoS.background.qosClass).async {
            DispatchQueue.main.async {
                self.updateCount()
            }
        }
    }
    func updateCount(){
        for button in circles{
            if button.tag <= activeUser.passcode.count{
                button.alpha = 1
            }
        }
        if(activeUser.passcode.count == 6){
            performSegue(withIdentifier: "passcodeComplete", sender:(Any).self)
            self.time.invalidate()
            
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        activeUser.passcode = ""
        for button in circles{
            button.alpha = 0
        }
    }
}

