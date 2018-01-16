//
//  Constants.swift
//  SmackApp
//
//  Created by Ramit sharma on 06/12/17.
//  Copyright © 2017 Ramit sharma. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Succes: Bool) -> ()
// URL Constants
let BASE_URL = "https://thatchatapp.herokuapp.com/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)users/byEmail/"

//Colors
let smakePlaceHolder = #colorLiteral(red: 0.1281911135, green: 0.4933825135, blue: 0.8569415212, alpha: 1)

//Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChange")

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// userdefaultsFoundation
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers
let HEADER = ["Content-Type": "application/json; charset_utf-8"]
let BEARER_HEADER =
    [ "Authorization" : "Bearer \(AuthService.instance.authToken)","Content-Type": "application/json; charset_utf-8"]



