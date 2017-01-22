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
            alignment = .left
            contentHorizontalAlignment = .left
            
        } else if string == "right" {
            alignment = .right
            contentHorizontalAlignment = .right
            
        } else if string == "center" {
            alignment = .center
            contentHorizontalAlignment = .center
            
        } else if string == "justify" {
            alignment = .justified
            contentHorizontalAlignment = .fill
            
        }
    }
}
