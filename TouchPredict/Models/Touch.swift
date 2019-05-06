//
//  TouchData.swift
//  FoodTracker
//
//  Created by Jordan Lewis on 4/19/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//
import  UIKit
import Foundation

class Touch{
    var location: CGPoint
    var radius: Float
    var force: Float
    var id: Int
    
    init(location: CGPoint, radius: Float, force: Float, id: Int) {
        self.location = location
        self.radius = radius
        self.force = force
        self.id = id
    }
    
    init(radius: Float, force: Float, id: Int) {
        self.location = CGPoint.init(x: 0, y: 0)
        self.radius = radius
        self.force = force
        self.id = id
    }
}
