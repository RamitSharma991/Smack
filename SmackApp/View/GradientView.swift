//
//  GradientView.swift
//  SmackApp
//
//  Created by Ramit sharma on 04/12/17.
//  Copyright © 2017 Ramit sharma. All rights reserved.
//

import UIKit
@IBDesignable
class GradientView: UIView {
   @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.2980392157, blue: 0.8745098039, alpha: 1)  {
    //IBInspectable variables change inside Storyboard dynamically
        
        didSet {
            
            self.setNeedsLayout()
            // Invalidates the current layout of the receiver and triggers a layout update during the next update cycle.
    }
    
}
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1){
    
    didSet {
    
    self.setNeedsLayout()
    }
    
}
    
    override func layoutSubviews() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
