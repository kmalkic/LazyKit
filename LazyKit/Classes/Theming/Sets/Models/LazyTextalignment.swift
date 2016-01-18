//
//  LazyTextalignment.swift
//  LazyKit
//
//  Created by Malkic Kevin on 30/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

class LazyTextalignment {
    
    var alignment: LazyTextAlignment?
    
    var contentHorizontalAlignment: UIControlContentHorizontalAlignment?
    
    init() {
    
    }
    
    init(string: String) {
        if string == "left" {
            alignment = .Left
            contentHorizontalAlignment = .Left
            
        } else if string == "right" {
            alignment = .Right
            contentHorizontalAlignment = .Right
            
        } else if string == "center" {
            alignment = .Center
            contentHorizontalAlignment = .Center
            
        } else if string == "justify" {
            alignment = .Justified
            contentHorizontalAlignment = .Fill
            
        }
    }
}


func + (left:LazyTextalignment?, right:LazyTextalignment? ) -> LazyTextalignment? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyTextalignment()
    
    object.alignment = left?.alignment + right?.alignment
    
    if right?.contentHorizontalAlignment != nil { object.contentHorizontalAlignment = right?.contentHorizontalAlignment } else { object.contentHorizontalAlignment = left?.contentHorizontalAlignment }
    
    return object
}