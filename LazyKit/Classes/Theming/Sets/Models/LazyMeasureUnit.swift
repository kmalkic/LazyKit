//
//  LazyMeasure.swift
//  LazyKit
//
//  Created by Kevin Malkic on 23/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

enum MeasureUnit: String {
	
    case Default = "default"
    case Pixel = "px"
    case Point = "pt"
    case Percent = "%"
    case Auto = "auto"
}

class LazyMeasure {
   
    var value: LazyFloat?
    
    var unit: MeasureUnit?
    
    init() {
        
    }
    
    init(string: String?) {
        
        setup(string)
    }
    
    func setup(string: String?) {
        
        value = valueFromString(string)
        unit = unitFromString(string)
    }
    
    func unitFromString(string: String?) -> MeasureUnit? {
		
		guard let string = string else {
		
			return nil
		}
		
        if string.containsString(MeasureUnit.Pixel.rawValue) {
			
            return .Pixel
			
        } else if string.containsString(MeasureUnit.Point.rawValue) {
			
            return .Point
			
        } else if string.containsString(MeasureUnit.Percent.rawValue) {
			
            return .Percent
			
        } else if string == MeasureUnit.Auto.rawValue {
			
            return .Auto
        }
		
        return .Default
    }
    
    func valueFromString(string: String?) -> LazyFloat? {
		
		guard let string = string else {
			
			return nil
		}
		
        let convertString = string.stringByReplacingOccurrencesOfString(" ", withString:"") as NSString
		
        var range: NSRange
		
        let units = [MeasureUnit.Pixel,MeasureUnit.Point,MeasureUnit.Percent]
        
        for unit in units {
            
            range = convertString.rangeOfString(unit.rawValue)
            
            if range.location != NSNotFound {
				
				let value = (convertString.substringToIndex(range.location) as NSString).floatValue
                
                return LazyFloat(value)
            }
        }
        
        return LazyFloat(convertString.floatValue)
    }
}
