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
    
    private func fetchImage() -> LazyImage! {
		
        if image == nil {
			
            image = LazyImage()
        }
		
        return image!
    }
    
    private func setImageContentMode(contentMode contentMode: String) {
		
        let tmpImage = fetchImage()
        tmpImage.setupContentModeWithString(contentMode)
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
            
            case kBackgroundKey, kBackgroundColorKey:
                if value.rangeOfString("rgb(") != nil || value.rangeOfString("rgba(") != nil || value.rangeOfString("#") != nil {
					
                    backgroundColor = LazyColor(anyString: value)
                }
                
            case kTintColorKey:
                if value.rangeOfString("rgb(") != nil || value.rangeOfString("rgba(") != nil || value.rangeOfString("#") != nil {
					
                    tintColor = LazyColor(anyString: value)
                }
                
            case kBarTintColorKey:
                if value.rangeOfString("rgb(") != nil || value.rangeOfString("rgba(") != nil || value.rangeOfString("#") != nil {
					
                    barTintColor = LazyColor(anyString: value)
                }
                
            case kBackgroundImageKey:
                if value.rangeOfString("url(") != nil {
					
                    //TODO
					
                } else {
					
                    fetchImage().imageName = value
                }
                
            case kBackgroundImageContentModeKey:
                setImageContentMode(contentMode: value)
                
            case kBackgroundImageTintColorKey:
                if value.rangeOfString("rgb(") != nil || value.rangeOfString("rgba(") != nil || value.rangeOfString("#") != nil {
					
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
