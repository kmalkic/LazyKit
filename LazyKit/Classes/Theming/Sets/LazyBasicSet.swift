//
//  BasicSet.swift
//  LazyKit
//
//  Created by Malkic Kevin on 22/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal let kBackgroundKey = "background"
internal let kBackgroundColorKey = "background-color"
internal let kTintColorKey = "tint-color"
internal let kBarTintColorKey = "bartint-color"

internal let kBackgroundImageKey = "background-image"
internal let kBackgroundImageContentModeKey = "background-image-content"
internal let kBackgroundImageTintColorKey = "background-image-tintColor"

internal class LazyBasicSet {
    
    var image: LazyImage?
    var barTintColor: LazyColor?
    var tintColor: LazyColor?
    var backgroundColor: LazyColor?
    
    init() {
        
    }
    
    fileprivate func fetchImage() -> LazyImage! {
		
        if image == nil {
			
            image = LazyImage()
        }
		
        return image!
    }
    
    fileprivate func setImageContentMode(contentMode: String) {
		
        let tmpImage = fetchImage()
        tmpImage?.setupContentModeWithString(contentMode)
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
            
            case kBackgroundKey, kBackgroundColorKey:
                if value.range(of: "rgb(") != nil || value.range(of: "rgba(") != nil || value.range(of: "#") != nil {
					
                    backgroundColor = LazyColor(anyString: value)
                }
                
            case kTintColorKey:
                if value.range(of: "rgb(") != nil || value.range(of: "rgba(") != nil || value.range(of: "#") != nil {
					
                    tintColor = LazyColor(anyString: value)
                }
                
            case kBarTintColorKey:
                if value.range(of: "rgb(") != nil || value.range(of: "rgba(") != nil || value.range(of: "#") != nil {
					
                    barTintColor = LazyColor(anyString: value)
                }
                
            case kBackgroundImageKey:
                if value.range(of: "url(") != nil {
					
                    //TODO
					
                } else {
					
                    fetchImage().imageName = value
                }
                
            case kBackgroundImageContentModeKey:
                setImageContentMode(contentMode: value)
                
            case kBackgroundImageTintColorKey:
                if value.range(of: "rgb(") != nil || value.range(of: "rgba(") != nil || value.range(of: "#") != nil {
					
                    fetchImage().tintColor = LazyColor(anyString: value)
                }
				
            default:
                break
            }
        }
        
        if isPropertiesNil() {
			
            return nil
        }
    }
    
    func isPropertiesNil() -> Bool {
		
        return barTintColor == nil && tintColor == nil && backgroundColor == nil && image == nil
    }

}
