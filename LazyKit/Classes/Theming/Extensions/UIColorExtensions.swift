//
//  UIColorExtensions.swift
//  LazyKit
//
//  Created by Kevin Malkic on 02/05/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

extension UIColor {
 
    public func red() -> CGFloat {
        let components = CGColorGetComponents(self.CGColor)
        return components[0]
    }
    
    public func blue() -> CGFloat {
        let components = CGColorGetComponents(self.CGColor)
        return components[2]
    }
    
    public func green() -> CGFloat {
        let components = CGColorGetComponents(self.CGColor)
        return components[1]
    }
    
    public func alpha() -> CGFloat {
        let components = CGColorGetComponents(self.CGColor)
        return components[3]
    }
    
    public class func random() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
    }
}

/**
 MissingHashMarkAsPrefix:   "Invalid RGB string, missing '#' as prefix"
 UnableToScanHexValue:      "Scan hex error"
 MismatchedHexStringLength: "Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8"
 */
public enum UIColorInputError : ErrorType {
    case MissingHashMarkAsPrefix,
    UnableToScanHexValue,
    MismatchedHexStringLength
}

extension UIColor {
    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.
     
     - parameter hex3: Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    public convenience init(hex3 hex: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex & 0x00F      ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The shorthand four-digit hexadecimal representation of color with alpha.
     #RGBA defines to the color #RRGGBBAA.
     
     - parameter hex4: Four-digit hexadecimal value.
     */
    public convenience init(hex4 hex: UInt16) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex & 0xF000) >> 12) / divisor
        let green   = CGFloat((hex & 0x0F00) >>  8) / divisor
        let blue    = CGFloat((hex & 0x00F0) >>  4) / divisor
        let alpha   = CGFloat( hex & 0x000F       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.
     
     - parameter hex6: Six-digit hexadecimal value.
     */
    public convenience init(hex6 hex: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
     
     - parameter hex8: Eight-digit hexadecimal value.
     */
    public convenience init(hex8 hex: UInt32) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex & 0x000000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, throws error.
     
     - parameter rgba: String value.
     */
    public convenience init(rgba_throws rgba: String) throws {
        guard rgba.hasPrefix("#") else {
            throw UIColorInputError.MissingHashMarkAsPrefix
        }
        
        guard let hexString: String = rgba.substringFromIndex(rgba.startIndex.advancedBy(1)),
            var   hexValue:  UInt32 = 0
            where NSScanner(string: hexString).scanHexInt(&hexValue) else {
                throw UIColorInputError.UnableToScanHexValue
        }
        
        guard hexString.characters.count  == 3
            || hexString.characters.count == 4
            || hexString.characters.count == 6
            || hexString.characters.count == 8 else {
                throw UIColorInputError.MismatchedHexStringLength
        }
        
        switch (hexString.characters.count) {
        case 3:
            self.init(hex3: UInt16(hexValue))
        case 4:
            self.init(hex4: UInt16(hexValue))
        case 6:
            self.init(hex6: hexValue)
        default:
            self.init(hex8: hexValue)
        }
    }
    
    /**
     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, fails to default color.
     
     - parameter rgba: String value.
     */
    public convenience init(rgba: String, defaultColor: UIColor = UIColor.clearColor()) {
        guard let color = try? UIColor(rgba_throws: rgba) else {
            self.init(CGColor: defaultColor.CGColor)
            return
        }
        self.init(CGColor: color.CGColor)
    }
}
