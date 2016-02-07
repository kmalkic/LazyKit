//
//  LazyTextalignment.swift
//  LazyKit
//
//  Created by Malkic Kevin on 30/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal class LazyTextAlignment {
    
    var alignment: NSTextAlignment?
    
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