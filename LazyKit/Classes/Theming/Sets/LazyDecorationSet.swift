//
//  DecorationSet.swift
//  LazyKit
//
//  Created by Malkic Kevin on 22/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal let kBorderKey          = "border"
internal let kBorderWidthKey     = "border-width"
internal let kBorderColorKey     = "border-color"
internal let kBorderRadiusKey    = "border-radius"


internal class LazyDecorationSet {
 
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
            
            let components = property.components(separatedBy: ":")
			
            if components.count != 2 {
				
                print("Invalid property should be 'key: value'\n")
                print(components)
                print("\n")
                return nil
            }
            
            let key = components[0].replacingOccurrences(of: " ", with: "")
            let rawValue = components[1].trimmingCharacters(in: .whitespaces).replacingOccurrences(of: ";", with: "")
            
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
