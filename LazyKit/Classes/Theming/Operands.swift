//
//  Operands.swift
//  LazyKit
//
//  Created by Kevin Malkic on 13/05/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

typealias LazyBool = Bool
typealias LazyInt = Int
typealias LazyString = String
typealias LazyFloat = CGFloat
typealias LazyTextAlignment = NSTextAlignment
typealias LazyLineBreakMode = NSLineBreakMode
typealias LazyViewContentMode = UIViewContentMode

func + (left:LazyBool?, right:LazyBool? ) -> LazyBool? {
    
    if left == nil && right == nil { return nil }
    var object:LazyBool?
    if right != nil { object = right } else { object = left }
    return object
}


func + (left:LazyInt?, right:LazyInt? ) -> LazyInt? {
    
    if left == nil && right == nil { return nil }
    var object:LazyInt?
    if right != nil { object = right } else { object = left }
    return object
}


func + (left:LazyString?, right:LazyString? ) -> LazyString? {
    
    if left == nil && right == nil { return nil }
    var object:LazyString?
    if right != nil { object = right } else { object = left }
    return object
}


func + (left:LazyFloat?, right:LazyFloat? ) -> LazyFloat? {
    
    if left == nil && right == nil { return nil }
    var object:LazyFloat?
    if right != nil { object = right } else { object = left }
    return object
}


func + (left:LazyTextAlignment?, right:LazyTextAlignment? ) -> LazyTextAlignment? {
    
    if left == nil && right == nil { return nil }
    var object:LazyTextAlignment?
    if right != nil { object = right } else { object = left }
    return object
}


func + (left:LazyLineBreakMode?, right:LazyLineBreakMode? ) -> LazyLineBreakMode? {
    
    if left == nil && right == nil { return nil }
    var object:LazyLineBreakMode?
    if right != nil { object = right } else { object = left }
    return object
}

func + (left:LazyViewContentMode?, right:LazyViewContentMode? ) -> LazyViewContentMode? {
    
    if left == nil && right == nil { return nil }
    var object:LazyViewContentMode?
    if right != nil { object = right } else { object = left }
    return object
}