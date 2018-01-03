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
    }
    
    // func to update the avatar name
}
