//
//  DecorationSet.swift
//  LazyKit
//
//  Created by Malkic Kevin on 22/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

let kBorderKey          = "border"
let kBorderWidthKey     = "border-width"
let kBorderColorKey     = "border-color"
let kBorderRadiusKey    = "border-radius"


class LazyDecorationSet {
 
    var borders: LazyBorders?
    
    init() {
        
    }
    
    func fetchBorders() -> LazyBorders {
		
        if borders == nil {
			
            borders = LazyBorders()
        }
		
        return borders!
    }
    
    init?(content: [String]!, variables: [String: String]?) {
        
        for property in content {
            
            let components = property.componentsSeparatedByString(":")
			
            if components.count != 2 {
				
                print("Invalid property should be 'key: value'\n")
                print(components)
                print("\n")
                return nil
            }
            
            let key = components[0].stringByReplacingOccurrencesOfString(" ", withString: "")
            let rawValue = components[1].stringByTrimmingCharactersInSet(.whitespaceCharacterSet()).stringByReplacingOccurrencesOfString(";", withString: "")
            
            var value = rawValue
            
            if let variables = variables {
				
				value = variables[rawValue] ?? rawValue
            }
            
            switch key {
                
            case kBorderKey:
                fetchBorders().setupBorder(key, value: value)
                
            case kBorderRadiusKey:
                fetchBorders().setupBorderRadius(key, value: value)
                
            case kBorderWidthKey:
                fetchBorders().setupBorderWidth(key, value: value)
                
            case kBorderColorKey:
                fetchBorders().setupBorderColor(key, value: value)
                
            default:
                break
            }
        }
        
        if isPropertiesNil() {
			
            return nil
        }
    }
    
    func isPropertiesNil() -> Bool {
		
        return borders == nil
    }
}
