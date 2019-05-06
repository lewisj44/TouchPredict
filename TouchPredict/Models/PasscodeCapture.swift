//
//  TouchCapture.swift
//  FoodTracker
//
//  Created by Jordan Lewis on 4/19/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//

import UIKit



class PasscodeCapture: UIGestureRecognizer, NSCoding{
    var trackedTouch: UITouch? = nil
    var activeUser: User = UserData.sharedManager.getActiveUser()
    var samples: [Touch] = UserData.sharedManager.getActiveUser().touches
    var rbfNet: RBFNetwork = RBFNetwork()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(target: nil, action: nil)
        self.samples = UserData.sharedManager.getActiveUser().touches
        
    }
    
    func addSample(for touch: UITouch) {
        if(activeUser.passcode.count < 6){
            let newSample = Touch(location: touch.location(in: touch.view), radius: Float(touch.majorRadius), force: Float(touch.force), id: activeUser.id)
            activeUser.addTouch(touch: newSample)
            activeUser.passcode += String(rbfNet.predictPasscode(touch: newSample))
            print(activeUser.passcode)
        }
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
