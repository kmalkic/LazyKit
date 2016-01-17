//
//  LazyColor.swift
//  LazyKit
//
//  Created by Malkic Kevin on 22/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

struct LazyColor {
   
    var red: Float = 0
    var green: Float = 0
    var blue: Float = 0
    var alpha: Float = 0
    
    init() {
        
    }
    
    init?(anyString: String) {
        if anyString.rangeOfString("rgba(") != nil {
            self.init(rgbaString:anyString)
        }
        else if anyString.rangeOfString("rgb(") != nil {
            self.init(rgbString:anyString)
        }
        else if anyString.rangeOfString("#") != nil {
            self.init(hexString:anyString)
        } else {
            return nil
        }
    }
    
    init(hexString: String) {
    
        var colorString = hexString.stringByReplacingOccurrencesOfString("#", withString:"").stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
        
        var range:NSRange = (colorString as NSString).rangeOfString(" ")
        if range.location != NSNotFound {
            colorString = (colorString as NSString).substringToIndex(range.location)
        }
        
        switch count(colorString) {
        case 3: // #RGB
            red     = colorComponentFrom(colorString, start: 0, length: 1)
            green   = colorComponentFrom(colorString, start: 1, length: 1)
            blue    = colorComponentFrom(colorString, start: 2, length: 1)
            alpha   = 1
        case 4: // #RGBA
            red     = colorComponentFrom(colorString, start: 0, length: 1)
            green   = colorComponentFrom(colorString, start: 1, length: 1)
            blue    = colorComponentFrom(colorString, start: 2, length: 1)
            alpha   = colorComponentFrom(colorString, start: 3, length: 1)
        case 6: // #RRGGBB
            red     = colorComponentFrom(colorString, start: 0, length: 2)
            green   = colorComponentFrom(colorString, start: 2, length: 2)
            blue    = colorComponentFrom(colorString, start: 4, length: 2)
            alpha   = 1
        case 8: // #RRGGBBAA
            red     = colorComponentFrom(colorString, start: 0, length: 2)
            green   = colorComponentFrom(colorString, start: 2, length: 2)
            blue    = colorComponentFrom(colorString, start: 4, length: 2)
            alpha   = colorComponentFrom(colorString, start: 6, length: 2)
        default:
//            var error: NSError?
//            NSException.raise("Invalid color value", format: "It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", arguments: getVaList([error ?? "nil"]))
            print("It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB\n")
            break
        }
    }
    
    init(rgbString: String) {
        
        let colorString = rgbString.stringByReplacingOccurrencesOfString("rgb(", withString:"").stringByReplacingOccurrencesOfString(")", withString:"").stringByReplacingOccurrencesOfString(" ", withString:"")
        
        let components = colorString.componentsSeparatedByString(",") as Array<String>
        
        if count(components) != 3 {
//            var error: NSError?
//            NSException.raise("Invalid color value", format: "It should be a rgb value of the form rgb(255,255,255)", arguments: getVaList([error ?? "nil"]))
            print("It should be a rgb value of the form rgb(255,255,255)\n")
        } else {
            red     = (components[0] as NSString).floatValue / 255.0
            green   = (components[1] as NSString).floatValue / 255.0
            blue    = (components[2] as NSString).floatValue / 255.0
            alpha   = 1
        }
    }
    
    init(rgbaString: String) {
        let colorString = rgbaString.stringByReplacingOccurrencesOfString("rgba(", withString:"").stringByReplacingOccurrencesOfString(")", withString:"").stringByReplacingOccurrencesOfString(" ", withString:"")
        
        let components = colorString.componentsSeparatedByString(",") as Array<String>
        
        if count(components) != 4 {
//            var error: NSError?
//            NSException.raise("Invalid color value", format: "It should be a rgb value of the form rgba(255,255,255)", arguments: getVaList([error ?? "nil"]))
            print("It should be a rgb value of the form rgba(255,255,255)\n")
        } else {
            red     = (components[0] as NSString).floatValue / 255.0
            green   = (components[1] as NSString).floatValue / 255.0
            blue    = (components[2] as NSString).floatValue / 255.0
            alpha   = (components[3] as NSString).floatValue
        }
    }

    private func colorComponentFrom(string: String, start: Int, length: Int) -> Float {
        
        let newString = string as NSString
        let substring = newString.substringWithRange(NSMakeRange(start, length))
        let fullHex = (length == 2) ? substring : String(format:"%@%@",substring,substring)
        var hexComponent: UInt32 = 0
        NSScanner(string: fullHex).scanHexInt(&hexComponent)
        return Float(hexComponent) / 255.0
    }
    
    func color() -> UIColor {
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    
}


func + (left:LazyColor?, right:LazyColor? ) -> LazyColor? {
    
    if left == nil && right == nil { return nil }
    
    var object:LazyColor?
    
    if right != nil { object = right } else { object = left }
    
    return object
}


