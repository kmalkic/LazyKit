//
//  LazyColor.swift
//  LazyKit
//
//  Created by Malkic Kevin on 22/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal func count(_ string: String) -> Int {

    return string.lengthOfBytes(using: String.Encoding.utf8)
}

internal struct LazyColor {
   
    var red: Float = 0
    var green: Float = 0
    var blue: Float = 0
    var alpha: Float = 0
    
    init() {
        
    }
    
    init?(anyString: String?) {
		
		guard let anyString = anyString else {
		
			return nil
		}
		
        if anyString.range(of: "rgba(") != nil {
			
            self.init(rgbaString:anyString)
			
        } else if anyString.range(of: "rgb(") != nil {
			
            self.init(rgbString:anyString)
			
        } else if anyString.range(of: "#") != nil {
			
            self.init(hexString:anyString)
			
        } else {
			
            return nil
        }
    }
    
    init(hexString: String) {
    
        var colorString = hexString.replacingOccurrences(of: "#", with:"").trimmingCharacters(in: .whitespaces)
        
        let range:NSRange = (colorString as NSString).range(of: " ")
        
        if range.location != NSNotFound {
            
            colorString = (colorString as NSString).substring(to: range.location)
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
        
        let colorString = rgbString.replacingOccurrences(of: "rgb(", with:"").replacingOccurrences(of: ")", with:"").replacingOccurrences(of: " ", with:"")
        
        let components = colorString.components(separatedBy: ",") as Array<String>
        
        if components.count != 3 {
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
		
        let colorString = rgbaString.replacingOccurrences(of: "rgba(", with:"").replacingOccurrences(of: ")", with:"").replacingOccurrences(of: " ", with:"")
        
        let components = colorString.components(separatedBy: ",") as Array<String>
        
        if components.count != 4 {
			
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

    fileprivate func colorComponentFrom(_ string: String, start: Int, length: Int) -> Float {
        
        let newString = string as NSString
        let substring = newString.substring(with: NSMakeRange(start, length))
        let fullHex = (length == 2) ? substring : String(format:"%@%@",substring,substring)
        var hexComponent: UInt32 = 0
        Scanner(string: fullHex).scanHexInt32(&hexComponent)
        return Float(hexComponent) / 255.0
    }
    
    func color() -> UIColor {
		
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    
}

