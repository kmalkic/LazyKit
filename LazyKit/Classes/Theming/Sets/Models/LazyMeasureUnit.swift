//
//  LazyMeasure.swift
//  LazyKit
//
//  Created by Kevin Malkic on 23/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal enum MeasureUnit: String {
	
    case Default = "default"
    case Pixel = "px"
    case Point = "pt"
    case Percent = "%"
    case Auto = "auto"
}

internal class LazyMeasure {
   
    var value: LazyFloat?
    
    var unit: MeasureUnit?
    
    init() {
        
    }
    
    init(string: String?) {
        
        setup(string)
    }
    
    func setup(_ string: String?) {
        
        value = valueFromString(string)
        unit = unitFromString(string)
    }
    
    func unitFromString(_ string: String?) -> MeasureUnit? {
		
		guard let string = string else {
		
			return nil
		}
		
        if string.contains(MeasureUnit.Pixel.rawValue) {
			
            return .Pixel
			
        } else if string.contains(MeasureUnit.Point.rawValue) {
			
            return .Point
			
        } else if string.contains(MeasureUnit.Percent.rawValue) {
			
            return .Percent
			
        } else if string == MeasureUnit.Auto.rawValue {
			
            return .Auto
        }
		
        return .Default
    }
    
    func valueFromString(_ string: String?) -> LazyFloat? {
		
		guard let string = string else {
			
			return nil
		}
		
        let convertString = string.replacingOccurrences(of: " ", with:"") as NSString
		
        var range: NSRange
		
        let units = [MeasureUnit.Pixel,MeasureUnit.Point,MeasureUnit.Percent]
        
        for unit in units {
            
            range = convertString.range(of: unit.rawValue)
            
            if range.location != NSNotFound {
				
				let value = (convertString.substring(to: range.location) as NSString).floatValue
                
                return LazyFloat(value)
            }
        }
        
        return LazyFloat(convertString.floatValue)
    }
}
