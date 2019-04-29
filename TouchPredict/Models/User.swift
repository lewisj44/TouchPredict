//
//  User.swift
//  FoodTracker
//
//  Created by Jordan Lewis on 4/19/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//

import UIKit

class User{
    //MARK: Properties
    var name: String
    var id: Int
    
    var avgRadius: Float
    var avgForce: Float
    
    var beta: Float
    var sigma: Float
    
    var r_variance: Float
    var f_variance: Float
    
    var r_stdDev: Float
    var f_stdDev: Float
    
    var touches: [TouchData] = []
    var previousSize = -1;
    
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
        
        self.avgRadius = 0;
        self.avgForce = 0;
        
        self.beta = 0
        self.sigma = 0
        
        
        self.r_variance = 0
        self.r_stdDev = 0
        self.f_variance = 0
        self.f_stdDev = 0
    }
    
    func addTouch(touch: TouchData){
        touches.append(touch)
        self.moveCentroid()
        self.previousSize = touches.count
    }
    
    func moveCentroid(){
        var radiusSum : Float = 0.0
        var forceSum : Float = 0.0
        for touch in touches{
            radiusSum += touch.radius
            forceSum += touch.force
        }
        avgRadius = radiusSum/Float(touches.count)
        avgForce = forceSum/Float(touches.count)
    }
    
    func updateBeta(){
        var sigmaSum: Float = 0
        var maxDist: Float = 0
        for touch in touches{
            let r_diff = (touch.radius - avgRadius)/r_stdDev
            let f_diff = (touch.force - avgForce)/f_stdDev
            print(name + " " + r_diff.description)
            print(name + " " + f_diff.description)
            let distance = sqrt(square(x: r_diff) + square(x: f_diff))
            sigmaSum += distance
            if distance > maxDist { maxDist = distance }
        }
       
        self.sigma = (sigmaSum/Float(touches.count))
        //self.sigma = maxDist/(2*Float(DataHandler.sharedManager.users.count))
        self.beta = 1/(2*square(x: sigma))
    }
    
    func calculateVariance(){
        let radiusMean = Float(touches.compactMap { $0.radius }.reduce(0, +))/Float(touches.count)
        let forceMean = Float(touches.compactMap { $0.force }.reduce(0, +))/Float(touches.count)
        
        var radiusVariance: Float = 0
        var forceVariance: Float = 0
        
        for (_, user) in DataHandler.sharedManager.usersID{
            let rdiff: Float = user.avgRadius - radiusMean
            let fdiff: Float = user.avgForce - forceMean
            
            radiusVariance += square(x: rdiff)
            forceVariance += square(x: fdiff)
        }
        self.r_variance = radiusVariance/Float(touches.count)
        self.f_variance = forceVariance/Float(touches.count)
        self.r_stdDev = sqrt(r_variance)
        self.f_stdDev = sqrt(f_variance)
    }
    
    func square(x: Float)->Float{
        return x*x
    }
    
    func reset(){
        avgRadius = 0.0
        avgForce = 0.0
        touches = []
    }
    
    
    
    
}
