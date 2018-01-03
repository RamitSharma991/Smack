//  AuthServices.swift
//  SmackApp
//  Created by Ramit sharma on 13/12/17.
//  Copyright © 2017 Ramit sharma. All rights reserved.
//  Handles all the Login,create user, Register user functions
//  This is a singleton; accessible globally but one instance at a time


import Foundation
import Alamofire
import SwiftyJSON



class AuthService {
    static let instance = AuthService()
    
    
    // variables that are used even after the app is closed like login details, Auth token and user emails
    let defaults = UserDefaults.standard
    var isLooggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)

        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
            
        }
        
    }
    
    func registerUser (email: String, password: String, completion: @escaping CompletionHandler) {
    
        let lowerCaseEmail = email.lowercased()
        //    let header = ["Content-Type": "application/json; charset_utf-8"]
        
        let body : [String: Any] = ["email": lowerCaseEmail, "password": password]

  
    // As web requests are asynchronous (we dont know when its gonna respond), so we use a completion handler to know when its finished
    
    Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString {
    (response) in
    
    if response.result.error == nil {
    completion(true)
    }
    
    else {
    
    completion(false)
    debugPrint(response.result.error as Any)
   
        }
        
    }
}
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler ) {
        
        let lowerCaseEmail = email.lowercased()
        let body : [String: Any] = ["email": lowerCaseEmail, "password": password]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
        //Using SwiftyJSON
                
                guard let data = response.data else {return}
              //  let json = JSON(data: data)
                let json = JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                self.isLooggedIn = true
                completion(true)
                
                // or
                //                if let json = response.result.value as? Dictionary<String,Any> {
                //                    if let email = json["user"] as? String {
                //
                //                        self.userEmail = email
                //                    }
                //                    if let token = json["token"] as? String {
                //                        self.authToken = token
                //                    }
                //                }
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
         
        }
        
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler)   {
        let lowerCaseEmail = email.lowercased()
        let body : [String: Any] = ["name": name, "email": lowerCaseEmail,  "avatarName": avatarName, "avatarColor": avatarColor ]
        
        
        let header = [ "Authorization" : "Bearer \(AuthService.instance.authToken)","Content-Type": "application/json; charset_utf-8"
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else {return}
                let json = JSON(data: data)
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue
            
                
                UserDataService.instance.setUserDataService(id: id, color: color, avatarName: avatarName, email: email, name: name)
                
                
            }
            
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
}
