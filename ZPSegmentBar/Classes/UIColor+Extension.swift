//
//  UIColor+Extension.swift
//  ZPSegmentBar
//
//  Created by 管章鹏 on 17/3/9.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

extension UIColor
{
    func getRGBValue() -> (CGFloat ,CGFloat,CGFloat) {
        
        var  red : CGFloat = 0
        var  blue : CGFloat = 0
        var green :CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        
  
        
        return (red,green,blue)
        
    }
}
