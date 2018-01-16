//
//  UserDataService.swift
//  SmackApp
//
//  Created by Ramit sharma on 03/01/18.
//  Copyright © 2018 Ramit sharma. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var Email = ""
    public private(set) var name = ""
    
    
    func setUserDataService(id: String, color: String, avatarName: String, email: String, name: String)  {
        
        self.id = id
        self.avatarName = avatarName
        self.Email = email
        self.avatarColor = color
        self.name = name

    }
    func setAvatarNamae(avatarName: String) {
        self.avatarName = avatarName
        
        // func to update the avatar name

    }
    
    
   //coloredBckgrndImg
    
    func returnColor(components: String) -> UIColor {
        
        // = [0.725498196078431, 0.749019607843137, 0.235294117647059, 1]
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }

        
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        return UIColor.red
    }
    
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        Email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
    }
    
}
