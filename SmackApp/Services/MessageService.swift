//
//  MessageService.swift
//  SmackApp
//
//  Created by Ramit sharma on 16/01/18.
//  Copyright © 2018 Ramit sharma. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    
//Channels and messages
    var channels = [Channel]()
    var selectedChannel : Channel?
    var unreadChannels = [String]()
    var messages = [Message]()
    
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                
/*  New Way
                do  {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                                } catch let error {
                                    debugPrint(error as Any)
                }
                print(self.channels)
*/
                
                
                

                // old Way
                if let json = try!JSON(data: data).array {
                    for item in json {let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)

                        self.channels.append(channel)
                    }
                    
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                }

            } else {
                
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler){
        //retrieves all messages for a given channel
        
        Alamofire.request("\(URL_GET_CHANNELS)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
               self.clearMessages()
                guard let data = response.data else {return}
                if let  json = try!JSON(data: data).array {
                    for item in json {

                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue

                        let message = Message(message: messageBody, username: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)

                        self.messages.append(message)
                    }
                    print(self.messages)
                    completion(true)

                }
                
            }
            else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    func clearChannels() {
        //clearing channels when logged out
        channels.removeAll()
    }
    
}
