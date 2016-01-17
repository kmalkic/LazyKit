//
//  LazyTextDecoration.swift
//  LazyKit
//
//  Created by Kevin Malkic on 30/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

class LazyTextDecoration {
   
    var underline: LazyBool?
    var strikethrough: LazyBool?
    var color: LazyColor?
    
    func setup(string: String) {
        if string == "none" {
            underline = false
            strikethrough = false
            
        } else if string == "underline" {
            underline = true
            strikethrough = false
            
        } else if string == "line-through" {
            strikethrough = true
            underline = false
        }
    }
}


func + (left:LazyTextDecoration?, right:LazyTextDecoration? ) -> LazyTextDecoration? {
    
    if left == nil && right == nil { return nil }
    
    var object = LazyTextDecoration()
    
    object.underline = left?.underline + right?.underline
    
    object.strikethrough = left?.strikethrough + right?.strikethrough
    
    object.color = left?.color + right?.color
    
    return object
}
