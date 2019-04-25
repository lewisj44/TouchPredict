//
//  ViewController.swift
//  FoodTracker
//
//  Created by Jordan Lewis on 4/19/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//
//
//  ViewController.swift
//  FoodTracker
//
//  Created by Jordan Lewis on 4/19/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//
import UIKit
import Foundation

class PredictViewController: UIViewController {
    //MARK: Properties
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var predictionStatsLabel: UILabel!
    @IBOutlet weak var predictionConfLabel: UILabel!
    @IBOutlet weak var predictionLabel: UILabel!
    var timer: Timer = Timer()
    var prediction: User = User(name: "Unknown", id: -1)
    var unknown: User = User(name: "Unknown", id: -1)
    var rbfNet: RBFNetwork = RBFNetwork()
    var previousSize = DataHandler.sharedManager.getPredictedUser().touches.count
    var samplingRate: Int = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prediction = User(name: "Unknown", id: -1)
        DataHandler.sharedManager.getPredictedUser().reset()
        predictionLabel.text = "Prediction: " + prediction.name
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) {
            timer in
            self.dataTimer(timer: timer)
        }
    }
    
    @IBAction func homeButton(_ sender: UIButton) {
        prediction = User(name: "Unknown", id: -1)
        DataHandler.sharedManager.getPredictedUser().reset()
        performSegue(withIdentifier: "homeFromAISegue", sender:(Any).self)
    }
    
    func dataTimer(timer:Timer) {
        DispatchQueue.global(qos: DispatchQoS.background.qosClass).async {
            DispatchQueue.main.async {
                if  DataHandler.sharedManager.getPredictedUser().touches.count > 0{
                    self.update()
                }
            }
        }
    }
    
    func update(){
        let predictUser: User = DataHandler.sharedManager.getPredictedUser()
        if touchAdded(){
            updateUserLabel()
            predictUser.touches = predictUser.touches.suffix(samplingRate)
            let minID: Int = rbfNet.predict(user: predictUser)
            updatePredictionLabel(minID: minID, probAr: rbfNet.output)
        }
        previousSize = DataHandler.sharedManager.getPredictedUser().touches.count
    }
    
    func updatePredictionLabel(minID: Int, probAr: [Float]){
        if(minID == -1){
            prediction = unknown
            predictionConfLabel.text = String(format: "Confidence: %.2f", 100 - probAr.max()!*Float(100)) + "%"
        }
        if DataHandler.sharedManager.userIDExists(userID: minID){
            prediction = DataHandler.sharedManager.getUserByID(id: minID)
            predictionConfLabel.text = String(format: "Confidence: %.2f", probAr.max()!*Float(100)) + "%"
        }
        predictionLabel.text = "Prediction: " + prediction.name
        predictionStatsLabel.text = String(format: "AvgRadius: %.2f AvgForce: %.2f", prediction.avgRadius, prediction.avgForce)
        
    }
    
    func updateUserLabel(){
        let predictUser: User = DataHandler.sharedManager.getPredictedUser()
        userLabel.text = String(format: "AvgRadius: %.2f AvgForce: %.2f", predictUser.avgRadius, predictUser.avgForce)
    }
    
    @IBAction func reset(_ sender: UIButton) {
        resetTest()
    }
    
    func resetTest(){
        rbfNet = RBFNetwork()
        prediction = User(name: "Unknown", id: -1)
        DataHandler.sharedManager.getPredictedUser().reset()
        predictionLabel.text = "Prediction: " + prediction.name
        userLabel.text = "AvgRadius: 0.00 AvgForce: 0.00"
        predictionLabel.text = "Prediction: " + prediction.name
        predictionConfLabel.text = "Confidence: "
        predictionStatsLabel.text = "AvgRadius: 0.00 AvgForce: 0.00"
    }
    
    func touchAdded()->Bool{
        return self.previousSize != DataHandler.sharedManager.getPredictedUser().touches.count
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        rateLabel.text = "Sample Rate: " + Int(slider.value).description
        samplingRate = Int(slider.value)
    }
}




