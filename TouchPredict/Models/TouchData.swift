//
//  TouchData.swift
//  FoodTracker
//
//  Created by Jordan Lewis on 4/19/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//
import  UIKit
import Foundation
class TouchData {
    var radius: Float
    var force: Float
    var id: Int
    
    init(radius: Float, force: Float, id: Int) {
        self.radius = radius
        self.force = force
        self.id = id
    }
}
