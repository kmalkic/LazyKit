//
//  LazyMeasure.swift
//  LazyKit
//
//  Created by Kevin Malkic on 23/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

enum MeasureUnit: Int {
    case Default
    case Pixel
    case Point
    case Percent
    case Auto
}

class LazyMeasure {
   
    var value: LazyFloat?
    
    var unit: MeasureUnit?
    
    init() {
        
    }
    
    init(string: String) {
        
        setup(string)
    }
    
    func setup(string: String) {
        
        value = CGFloat(valueFromString(string))
        unit = unitFromString(string)
    }
    
    func unitFromString(string:String) -> MeasureUnit {
        
        let convertString = string.stringByReplacingOccurrencesOfString(" ", withString:"")
        
        if convertString.rangeOfString("px") != nil {
            return .Pixel
        }
        else if convertString.rangeOfString("pt") != nil {
            return .Point
        }
        else if convertString.rangeOfString("%") != nil {
            return .Percent
        }
        else if convertString == "auto" {
            return .Auto
        }
        return .Default
    }
    
    func valueFromString(string:String) -> Float {
        
        let convertString = string.stringByReplacingOccurrencesOfString(" ", withString:"") as NSString
        var range:NSRange
        let tests = ["px","pt","%"]
        
        for test in tests {
            
            range = convertString.rangeOfString(test)
            
            if range.location != NSNotFound {
                
                return (convertString.substringToIndex(range.location) as NSString).floatValue
            }
        }
        
        return convertString.floatValue
    }
}
