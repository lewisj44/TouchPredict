//
//  ViewController.swift
//  FoodTracker
//
//  Created by Jordan Lewis on 4/19/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//

import UIKit

class LoadUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    //MARK: Properties
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (id, user) in DataHandler.sharedManager.usersID{
            let nameString = user.name
            pickerData.append(nameString)
        }
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView)->Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)->String? {
        return pickerData[row]
    }
    @IBAction func loadUser(_ sender: UIButton) {
        let selectedRow = picker.selectedRow(inComponent: 0)
        let userName = pickerData[selectedRow]
        if DataHandler.sharedManager.userNameExists(userName: userName){
            DataHandler.sharedManager.activeUser = DataHandler.sharedManager.users[userName]!
            performSegue(withIdentifier: "loadedUserSegue", sender:(Any).self)
        }
    }
}

