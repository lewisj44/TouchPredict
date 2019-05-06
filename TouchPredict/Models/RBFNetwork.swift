



import Foundation
import UIKit

public class RBFNetwork {
    //var weights: [[Float]]
    var rbf: [Float]
    var passcodeRBF: [Float]
    var output: [Float]
    
    var numUsers: Int = UserData.sharedManager.users.count
    var threshold: Float
    
    init(){
        //weights = [[Float]](repeating: [Float](repeating: 1, count: numUsers), count: numUsers)
        rbf = [Float](repeating: 0, count: numUsers)
        passcodeRBF = [Float](repeating: 0, count: UserData.sharedManager.digits.count)
        output = [Float](repeating: 0, count: numUsers)
        threshold = 1/Float(numUsers)
        numUsers = UserData.sharedManager.users.count
        
        for (_, user) in UserData.sharedManager.usersID{
            user.calculateVariance()
            user.updateBeta()
        }
    }
    
    func predict(user: User)->Int{
        numUsers = UserData.sharedManager.users.count
        //Hidden Layer
        rbf = RBFLayer(input: user)
        //Output Layer
        output = rbf
        print(rbf.description)
        return outputLayer(input: output)
    }
    
    func predict(touch: Touch)->Int{
        numUsers = UserData.sharedManager.users.count
        //Hidden Layer
        rbf = passcodeRBFLayer(input: touch)
        //Output Layer
        output = rbf
        print(rbf.description)
        return passcodeOutputLayer(input: output)
    }
    
    
    //LAYERS
    func RBFLayer(input: User) -> [Float] {
        rbf = [Float](repeating: 0, count: numUsers)
        for (id, user) in UserData.sharedManager.usersID{
            let r_diff = (input.avgRadius - user.avgRadius)/user.r_stdDev
            let f_diff = (input.avgForce - user.avgForce)/user.f_stdDev
            let distance = sqrt(square(x: r_diff) + square(x: f_diff))
            rbf[id-1] = exp(-1*user.beta*square(x: distance))
        }
        return rbf
    }
    
    func passcodeRBFLayer(input: Touch) -> [Float] {
        passcodeRBF = [Float](repeating: 0, count: UserData.sharedManager.digits.count)
        for (digit, location) in UserData.sharedManager.digits{
            let x_diff = Float(input.location.x) - location[0]
            let y_diff = Float(input.location.y) - location[1]
            let distance = sqrt(square(x: x_diff) + square(x: y_diff))
            passcodeRBF[Int(digit)!] = exp(-1*0.005*square(x: distance))
        }
        return passcodeRBF
    }
    
    func outputLayer(input: [Float])->Int{
        var prediction = -1
        if input.max() != nil && input.firstIndex(of: input.max()!) != nil{
            if input.max()! - input.min()! > threshold/100 && input.max()! >= threshold{
                prediction = input.firstIndex(of: input.max()!)!+1
            }
        }
        return prediction
    }
    
    func passcodeOutputLayer(input: [Float])->Int{
        var prediction = -1
        if input.max() != nil && input.firstIndex(of: input.max()!) != nil{
            prediction = input.firstIndex(of: input.max()!)!
        }
        return prediction
    }
    
    func softmaxLayer(input: [Float]) -> [Float]{
        let x: [Float] = input
        let ex: [Float] = x.map{exp($0)}
        let sum_ex = ex.reduce(0, +)
        return ex.map{$0/sum_ex}
    }
    
    //HELPER FUNCTIONS
    func square(x: Float)->Float{
        return x*x
    }
}

