//
//  ViewController.swift
//  FoodTracker
//
//  Created by Jordan Lewis on 4/19/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//

import UIKit
import Foundation

class CaptureViewController: UIViewController {
    var activeUser: User = UserData.sharedManager.getActiveUser()
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var touchLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton.isHidden = true
        self.testButton.isHidden = true
        updateData()
        userLabel.text = "Active User: " + UserData.sharedManager.getActiveUser().name
        _ = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) {
            timer in
    
            self.dataTimer(timer: timer)
            
        }
    }
    func dataTimer(timer:Timer) {
        DispatchQueue.global(qos: DispatchQoS.background.qosClass).async {
            DispatchQueue.main.async {
                self.updateData()
            }
        }
    }
    
    func updateData() {
        touchLabel.text = "Touches: " + String(activeUser.touches.count)
        dataLabel.text = String(format: "AvgRadius: %.2f AvgForce: %.2f", activeUser.avgRadius, activeUser.avgForce)
        if activeUser.touches.count > UserData.sharedManager.mintouches {
            self.saveButton.isHidden = false
            if UserData.sharedManager.users.count > 1{
                self.testButton.isHidden = false
            }
        }
        
    }
    
    @IBAction func saveData(_ sender: UIButton) {
        if activeUser.touches.count > 1{
            performSegue(withIdentifier: "saveDataSegue", sender:(Any).self)
        }
    }
    
    @IBAction func test(_ sender: UIButton) {
        if activeUser.touches.count > 1 && UserData.sharedManager.users.count > 1{
            performSegue(withIdentifier: "testSegue", sender:(Any).self)
        }
    }
    
}

