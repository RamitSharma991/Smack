//
//  channelCell.swift
//  SmackApp
//
//  Created by Ramit sharma on 17/01/18.
//  Copyright © 2018 Ramit sharma. All rights reserved.
//

import UIKit
@IBDesignable


class channelCell: UITableViewCell {

    //outlets
    
    @IBOutlet weak var channelName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
            
        }
            
            else {
                self.layer.backgroundColor = UIColor.clear.cgColor
            }
        }
        
        func configureCell(channel: Channel) {
            
            let title = channel.channelTitle ?? ""
            channelName.text = "#\(title)"
            channelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
            for id in MessageService.instance.unreadChannels {
                if id == channel.id {
                    channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
                }
            }
        }

        // Configure the view for the selected state
    }


