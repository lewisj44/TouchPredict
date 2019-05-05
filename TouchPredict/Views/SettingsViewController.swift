//
//  SettingsViewController.swift
//  TouchPredict
//
//  Created by Jordan Lewis on 4/27/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//
import UIKit

class SettingsViewController: UIViewController{
    
    @IBOutlet weak var minTouchesLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var minTouchesSlider: UISlider!
    @IBOutlet weak var rateSlider: UISlider!
    
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateSlider.value =  Float(UserData.sharedManager.sampleRate)
        minTouchesSlider.value =  Float(UserData.sharedManager.mintouches)
        
    }
    
    @IBAction func minTouchesChanged(_ sender: Any) {
        minTouchesLabel.text = Int(minTouchesSlider.value).description
        UserData.sharedManager.mintouches = Int(minTouchesSlider.value)
    }
    
    @IBAction func rateChanged(_ sender: Any) {
        rateLabel.text = Int(rateSlider.value).description
        UserData.sharedManager.sampleRate = Int(rateSlider.value)
    }
    @IBAction func closeSettings(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
