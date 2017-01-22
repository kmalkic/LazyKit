//
//  OptionSet.swift
//  LazyKit
//
//  Created by Malkic Kevin on 22/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal let kBar_TranslucentKey         = "translucent"

internal class LazyOptionSet {

    var translucent: LazyBool?
    
    init() {
        
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
                             
            case kBar_TranslucentKey:
				
                translucent = (value as NSString).boolValue
                
            default:
                break
            }
        }
        
        if isPropertiesNil() {
            
            return nil
        }
    }
    
    func isPropertiesNil() -> Bool {
        
        return translucent == nil
    }
}
