//
//  LaunchViewController.swift
//  TouchAnalytics
//
//  Created by Jordan Lewis on 4/21/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//

import UIKit
import Foundation

class LaunchViewController: UIViewController{
    //MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func testAI(_ sender: UIButton) {
        if DataHandler.sharedManager.users.count>0 && (DataHandler.sharedManager.getUserByID(id: 1).touches.count) > 0 {
            performSegue(withIdentifier: "testAISegue", sender:(Any).self)
        }
    }


}
