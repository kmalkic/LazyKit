//
//  LazyTextStroke.swift
//  LazyKit
//
//  Created by Malkic Kevin on 30/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

class LazyTextStroke {
   
    var width: LazyMeasure?
    
    var color: LazyColor?

}


func + (left:LazyTextStroke?, right:LazyTextStroke? ) -> LazyTextStroke? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyTextStroke()
    
    object.color = left?.color + right?.color
    
    object.width = left?.width + right?.width
    
    return object
}