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
        rateSlider.value =  Float(DataHandler.sharedManager.sampleRate)
        minTouchesSlider.value =  Float(DataHandler.sharedManager.mintouches)
        
    }
    
    @IBAction func minTouchesChanged(_ sender: Any) {
        minTouchesLabel.text = Int(minTouchesSlider.value).description
        DataHandler.sharedManager.mintouches = Int(minTouchesSlider.value)
    }
    
    @IBAction func rateChanged(_ sender: Any) {
        rateLabel.text = Int(rateSlider.value).description
        DataHandler.sharedManager.sampleRate = Int(rateSlider.value)
    }
    @IBAction func closeSettings(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
