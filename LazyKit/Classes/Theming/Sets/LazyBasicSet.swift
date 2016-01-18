//
//  BasicSet.swift
//  LazyKit
//
//  Created by Malkic Kevin on 22/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

let kBackgroundKey = "background"
let kBackgroundColorKey = "background-color"
let kTintColorKey = "tint-color"
let kBarTintColorKey = "bartint-color"

let kBackgroundImageKey = "background-image"
let kBackgroundImageContentModeKey = "background-image-content"
let kBackgroundImageTintColorKey = "background-image-tintColor"

class LazyBasicSet {
    
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
            
            if variables != nil {
                if variables![rawValue] != nil {
                    value = variables![rawValue]!
                }
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


func + (left:LazyBasicSet?, right:LazyBasicSet? ) -> LazyBasicSet? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyBasicSet()
    
    object.backgroundColor  = left?.backgroundColor + right?.backgroundColor
    
    object.tintColor        = left?.tintColor + right?.tintColor
    
    object.barTintColor     = left?.barTintColor + right?.barTintColor
    
    object.image            = left?.image + right?.image
    
    return object
}


