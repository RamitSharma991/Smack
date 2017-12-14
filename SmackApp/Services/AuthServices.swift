//  AuthServices.swift
//  SmackApp
//  Created by Ramit sharma on 13/12/17.
//  Copyright © 2017 Ramit sharma. All rights reserved.
//  Handles all the Login,create user, Register user functions
//  This is a singleton; accessible globally but one instance at a time


import Foundation
import Alamofire



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
        
        let header = ["Content-Type": "application/json; charset_utf-8"]
        
        let body : [String: Any] = ["email": lowerCaseEmail, "password": password]

  
    // As web requests are asynchronous (we dont know when its gonna respond), so we use a completion handler to know when its finished
    
    Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString {
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


}





