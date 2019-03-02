//
//  Constant.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation
import UIKit

class BackgroundColor {
   
    static func getAllBackgroundColors() -> [UIColor] {
        var bgColors = [UIColor]()
        bgColors.append(self.hexStringToUIColor(hex: "#16702e"))
        bgColors.append(self.hexStringToUIColor(hex: "#005a51"))
        bgColors.append(self.hexStringToUIColor(hex: "#996c00"))
        bgColors.append(self.hexStringToUIColor(hex: "#5c0a6b"))
        bgColors.append(self.hexStringToUIColor(hex: "#006d90"))
        bgColors.append(self.hexStringToUIColor(hex: "#974e06"))
        bgColors.append(self.hexStringToUIColor(hex: "#99272e"))
        bgColors.append(self.hexStringToUIColor(hex: "#89221f"))
        bgColors.append(self.hexStringToUIColor(hex: "#00345d"))
        return bgColors
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
