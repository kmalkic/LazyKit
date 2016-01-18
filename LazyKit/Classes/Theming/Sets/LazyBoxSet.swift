//
//  LazyBoxSet.swift
//  LazyKit
//
//  Created by Malkic Kevin on 18/05/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

let kBoxWidthKey        = "width"
let kBoxHeightKey       = "height"
let kBoxMarginKey       = "margin"
let kBoxPaddingKey      = "padding"
let kBoxPositionKey     = "position"

class LazyBoxSet {
   
    var width: LazyMeasure?
    var height: LazyMeasure?
    var margin: LazyEdges?
    var padding: LazyEdges?
    
    init() {
        
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
                
            case kBoxWidthKey:
                width = LazyMeasure(string: value)
                
            case kBoxHeightKey:
                height = LazyMeasure(string: value)
                
            case kBoxMarginKey:
                margin = LazyEdges(string: value)
                
            case kBoxPaddingKey:
                padding = LazyEdges(string: value)
                
            default:
                break
            }
        }
        
        if isPropertiesNil() {
            return nil
        }
    }
    
    func isPropertiesNil() -> Bool {
        return width == nil && height == nil
    }
    
    func size() -> CGSize {
        if width?.value != nil && height?.value != nil {
            return CGSizeMake(width!.value!, height!.value!)
        }
        return CGSizeZero
    }
    
}

func + (left:LazyBoxSet?, right:LazyBoxSet? ) -> LazyBoxSet? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyBoxSet()
    
    object.width = left?.width + right?.width
    
    object.height = left?.height + right?.height
    
    object.margin = left?.margin + right?.margin
    
    object.padding = left?.padding + right?.padding
    
    return object
}


