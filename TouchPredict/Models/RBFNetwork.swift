



import Foundation

public class RBFNetwork {
    var weights: [[Float]]
    var rbf: [Float]
    var output: [Float]
    
    var numUsers: Int = DataHandler.sharedManager.users.count
    
    let learningRate: Float = 0.004
    let iterations = 500
    var threshold: Float
    
    init(){
        weights = [[Float]](repeating: [Float](repeating: 1, count: numUsers), count: numUsers)
        rbf = [Float](repeating: 0, count: numUsers)
        output = [Float](repeating: 0, count: numUsers)
        threshold = 1/Float(numUsers)
        for (_, user) in DataHandler.sharedManager.usersID{
            user.calculateVariance()
            user.updateBeta()
        }
    }
    
    func predict(user: User)->Int{
        numUsers = DataHandler.sharedManager.users.count
        //Hidden Layer 1
        rbf = RBFLayer(input: user)
        print("RBF: " + rbf.description)
        output = rbf
        return outputLayer(input: output)
    }
    
    
    //LAYERS
    func RBFLayer(input: User) -> [Float] {
        rbf = [Float](repeating: 0, count: numUsers)
        for (id, user) in DataHandler.sharedManager.usersID{
            //let coeff: Float = 1/(user.sigmaF*sqrt(2*Float.pi))
            let r_diff = (input.avgRadius - user.avgRadius)/user.r_stdDev
            let f_diff = (input.avgForce - user.avgForce)/user.f_stdDev
            let distance = sqrt(square(x: r_diff) + square(x: f_diff))
            rbf[id-1] = exp(-1*user.beta*square(x: distance))
        }
        return rbf
    }
    
    func softMaxLayer(input: [Float])->[Float]{
        let prob: [Float] = softmax(input: input)
        return prob
    }
    
    func outputLayer(input: [Float])->Int{
        var prediction = -1
        if input.max() != nil && input.firstIndex(of: input.max()!) != nil{
            if input.max()! - input.min()! > threshold/10 && input.max()! >= threshold{
                prediction = input.firstIndex(of: input.max()!)!+1
            }
        }
        return prediction
    }
    
    //HELPER FUNCTIONS
    func softmax(input: [Float]) -> [Float]{
        let x: [Float] = input
        let ex: [Float] = x.map{exp($0)}
        let sum_ex = ex.reduce(0, +)
        return ex.map{$0/sum_ex}
    }
    
    func square(x: Float)->Float{
        return x*x
    }
}

