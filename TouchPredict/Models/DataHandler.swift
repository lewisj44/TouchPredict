//
//  DataHandler.swift
//  FoodTracker
//
//  Created by Jordan Lewis on 4/19/19.
//  Copyright © 2019 Jordan Lewis. All rights reserved.
//

import UIKit
import Foundation

class DataHandler{
    //MARK: Properties
    var users: [String: User] = [:]
    var usersID: [Int: User] = [:]
    var activeUser : User
    var predictedUser: User
    var userID : Int = 0
    
    init(){
        activeUser = User(name: "placeholder", id: 0)
        predictedUser = User(name: "Unknown", id: -1)
    }
    
    class var sharedManager: DataHandler {
        struct Static {
            static let instance = DataHandler()
        }
        return Static.instance
    }
    
    func addUser(user: User){
        if !userNameExists(userName: user.name) && !userIDExists(userID: user.id) {
            users[user.name] = user
            usersID[user.id] = user
        }
    }
    
    func userNameExists(userName: String) -> Bool{
        if users[userName] != nil{
            return true
        }
        else{
            return false
        }
    }
    
    func userIDExists(userID: Int) -> Bool{
        if usersID[userID] != nil{
            return true
        }
        else{
            return false
        }
    }
    
    func getUserByID(id: Int) -> User{
        return usersID[id]!
        
    }
    
    func getUserByName(name: String) -> User{
        return users[name]!
        
    }
    
    func setActiveUser(user: User){
        activeUser = user;
    }
    
    func getActiveUser() -> User{
        return activeUser
    }
    
    func setPredictedUser(user: User){
        predictedUser = user;
    }
    
    func getPredictedUser() -> User{
        return predictedUser
    }
    
    func getUserID() -> Int{
        userID += 1
        return userID;
    }
}
