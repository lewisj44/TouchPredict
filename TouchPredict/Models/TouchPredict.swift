//
//  TouchCapture.swift
//  FoodTracker
//
//  Created by Jordan Lewis on 4/19/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//

import UIKit



class TouchPredict: UIGestureRecognizer, NSCoding{
    var trackedTouch: UITouch? = nil
    var predictUser: User = UserData.sharedManager.getPredictedUser()
    var samples: [Touch] = UserData.sharedManager.getPredictedUser().touches
    
    required init?(coder aDecoder: NSCoder) {
        super.init(target: nil, action: nil)
    }
    
    func addSample(for touch: UITouch) {
        let newSample = Touch(radius: Float(touch.majorRadius), force: Float(touch.force), id: predictUser.id)
        predictUser.addTouch(touch: newSample)
    }
    
    func encode(with aCoder: NSCoder) { }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        //print("Touch Began")
        if touches.count != 1 {
            self.state = .failed
        }
        // Capture the first touch and store some information about it.
        if self.trackedTouch == nil {
            if let firstTouch = touches.first {
                self.trackedTouch = firstTouch
                self.addSample(for: firstTouch)
                state = .began
            }
        } else {
            // Ignore all but the first touch.
            for touch in touches {
                if touch != self.trackedTouch {
                    self.ignore(touch, for: event)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addSample(for: touches.first!)
        state = .changed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Touch Ended")
        //self.addSample(for: touches.first!)
        state = .ended
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.samples.removeAll()
        state = .cancelled
    }
    
    override func reset() {
        self.samples.removeAll()
        self.trackedTouch = nil
    }
}
