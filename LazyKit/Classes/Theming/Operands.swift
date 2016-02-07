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
typealias LazyLineBreakMode = NSLineBreakMode
typealias LazyViewContentMode = UIViewContentMode

internal func + (left:LazyBool?, right:LazyBool? ) -> LazyBool? {
    
    if left == nil && right == nil { return nil }
    var object:LazyBool?
    if right != nil { object = right } else { object = left }
    return object
}


internal func + (left:LazyInt?, right:LazyInt? ) -> LazyInt? {
    
    if left == nil && right == nil { return nil }
    var object:LazyInt?
    if right != nil { object = right } else { object = left }
    return object
}


internal func + (left:LazyString?, right:LazyString? ) -> LazyString? {
    
    if left == nil && right == nil { return nil }
    var object:LazyString?
    if right != nil { object = right } else { object = left }
    return object
}


internal func + (left:LazyFloat?, right:LazyFloat? ) -> LazyFloat? {
    
    if left == nil && right == nil { return nil }
    var object:LazyFloat?
    if right != nil { object = right } else { object = left }
    return object
}


internal func + (left:NSTextAlignment?, right:NSTextAlignment? ) -> NSTextAlignment? {
    
    if left == nil && right == nil { return nil }
    var object:NSTextAlignment?
    if right != nil { object = right } else { object = left }
    return object
}


internal func + (left:LazyLineBreakMode?, right:LazyLineBreakMode? ) -> LazyLineBreakMode? {
    
    if left == nil && right == nil { return nil }
    var object:LazyLineBreakMode?
    if right != nil { object = right } else { object = left }
    return object
}

internal func + (left:LazyViewContentMode?, right:LazyViewContentMode? ) -> LazyViewContentMode? {
    
    if left == nil && right == nil { return nil }
    var object:LazyViewContentMode?
    if right != nil { object = right } else { object = left }
    return object
}

internal func + (left:LazyBorders?, right:LazyBorders? ) -> LazyBorders? {
    
    if left == nil && right == nil { return nil }
    
    var object:LazyBorders?
    
    if right != nil { object = right } else { object = left }
    
    return object
}

internal func + (left:LazyColor?, right:LazyColor? ) -> LazyColor? {
    
    if left == nil && right == nil { return nil }
    
    var object:LazyColor?
    
    if right != nil { object = right } else { object = left }
    
    return object
}

internal func + (left:LazyEdges?, right:LazyEdges? ) -> LazyEdges? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyEdges()
    
    object.top = left?.top + right?.top
    
    object.left = left?.left + right?.left
    
    object.bottom = left?.bottom + right?.bottom
    
    object.right = left?.right + right?.right
    
    return object
}

internal func + (left:LazyImage?, right:LazyImage? ) -> LazyImage? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyImage()
    
    object.contentMode = left?.contentMode + right?.contentMode
    
    object.imageName = left?.imageName + right?.imageName
    
    object.tintColor = left?.tintColor + right?.tintColor
    
    return object
}

internal func + (left:LazyMeasure?, right:LazyMeasure? ) -> LazyMeasure? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyMeasure()
    
    object.value = left?.value + right?.value
    
    object.unit = left?.unit + right?.unit
    
    return object
}

internal func + (left:MeasureUnit?, right:MeasureUnit? ) -> MeasureUnit? {
    
    if left == nil && right == nil { return nil }
    
    var object:MeasureUnit?
    
    if right != nil { object = right } else { object = left }
    
    return object
}

internal func + (left:LazyFont?, right:LazyFont? ) -> LazyFont? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyFont()
    
    object.fontName = left?.fontName + right?.fontName
    
    object.fontSize = left?.fontSize + right?.fontSize
    
    return object
}

internal func + (left:LazyTextStroke?, right:LazyTextStroke? ) -> LazyTextStroke? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyTextStroke()
    
    object.color = left?.color + right?.color
    
    object.width = left?.width + right?.width
    
    return object
}

internal func + (left:LazyTextDecoration?, right:LazyTextDecoration? ) -> LazyTextDecoration? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyTextDecoration()
    
    object.underline = left?.underline + right?.underline
    
    object.strikethrough = left?.strikethrough + right?.strikethrough
    
    object.color = left?.color + right?.color
    
    return object
}

internal func + (left:LazyTextAlignment?, right:LazyTextAlignment? ) -> LazyTextAlignment? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyTextAlignment()
    
    object.alignment = left?.alignment + right?.alignment
    
    if right?.contentHorizontalAlignment != nil { object.contentHorizontalAlignment = right?.contentHorizontalAlignment } else { object.contentHorizontalAlignment = left?.contentHorizontalAlignment }
    
    return object
}

internal func + (left:LazyParagraph?, right:LazyParagraph? ) -> LazyParagraph? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyParagraph()
    
    object.alignment = left?.alignment + right?.alignment
    
    object.lineBreakMode = left?.lineBreakMode + right?.lineBreakMode
    
    object.lineSpacing = left?.lineSpacing + right?.lineSpacing
    
    object.paragraphSpacing = left?.paragraphSpacing + right?.paragraphSpacing
    
    object.headIndent = left?.headIndent + right?.headIndent
    
    return object
}

internal func + (left:LazyTextSet?, right:LazyTextSet? ) -> LazyTextSet? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyTextSet()
    
    object.fontObj = left?.fontObj + right?.fontObj
    
    object.textAlignment = left?.textAlignment + right?.textAlignment
    
    object.textColor = left?.textColor + right?.textColor
    
    object.paragraph = left?.paragraph + right?.paragraph
    
    object.textStroke = left?.textStroke + right?.textStroke
    
    object.textDecoration = left?.textDecoration + right?.textDecoration
    
    object.numberOfLines = left?.numberOfLines + right?.numberOfLines
    
    return object
}

internal func + (left:LazyOptionSet?, right:LazyOptionSet? ) -> LazyOptionSet? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyOptionSet()
    
    object.translucent = left?.translucent + right?.translucent
    
    return object
}

internal func + (left:LazyDecorationSet?, right:LazyDecorationSet? ) -> LazyDecorationSet? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyDecorationSet()
    
    object.borders  = left?.borders + right?.borders
    
    return object
}

internal func + (left:LazyBasicSet?, right:LazyBasicSet? ) -> LazyBasicSet? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyBasicSet()
    
    object.backgroundColor  = left?.backgroundColor + right?.backgroundColor
    
    object.tintColor        = left?.tintColor + right?.tintColor
    
    object.barTintColor     = left?.barTintColor + right?.barTintColor
    
    object.image            = left?.image + right?.image
    
    return object
}

internal func + (left:LazyStyleSet?, right:LazyStyleSet? ) -> LazyStyleSet? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyStyleSet()
    
    object.basicSet         = left?.basicSet + right?.basicSet
    
    object.decorationSet    = left?.decorationSet + right?.decorationSet
    
    object.optionSet        = left?.optionSet + right?.optionSet
    
    object.textSet          = left?.textSet + right?.textSet
    
    object.placeholderSet   = left?.placeholderSet + right?.placeholderSet
    
    return object
}

