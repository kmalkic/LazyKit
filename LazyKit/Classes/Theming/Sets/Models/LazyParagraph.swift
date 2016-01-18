//
//  LazyParagraph.swift
//  LazyKit
//
//  Created by Kevin Malkic on 28/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

class LazyParagraph {
    
    var lineSpacing: LazyMeasure?
    
    var paragraphSpacing: LazyMeasure?
    
    var headIndent: LazyMeasure?
    
    var alignment: LazyTextAlignment?
    
    var lineBreakMode: LazyLineBreakMode?
    
    
    func convertWordWrap(wordWrap: String) -> NSLineBreakMode {
        
        switch wordWrap {
        case "word-wrapping":
            return .ByWordWrapping
        case "char-wrapping":
            return .ByCharWrapping
        case "clipping":
            return .ByClipping
        case "truncating-head":
            return .ByTruncatingHead
        case "truncating-tail":
            return .ByTruncatingTail
        case "truncating-middle":
            return .ByTruncatingMiddle
        default:
            break
        }
        return .ByTruncatingTail
    }
    
    func paragraphStyle() -> NSParagraphStyle! {
        let paragraphStyle = NSMutableParagraphStyle()
        if let value = lineSpacing?.value {
            paragraphStyle.lineSpacing = value
        }
        if let value = paragraphSpacing?.value {
            paragraphStyle.paragraphSpacing = value
        }
        if let value = headIndent?.value {
            paragraphStyle.firstLineHeadIndent = value
        }
        if let value = alignment {
            paragraphStyle.alignment = value
        } else {
            paragraphStyle.alignment = .Left
        }
        if let value = lineBreakMode {
            paragraphStyle.lineBreakMode = value
        } else {
            paragraphStyle.lineBreakMode = .ByTruncatingTail
        }
        return paragraphStyle
    }

}


func + (left:LazyParagraph?, right:LazyParagraph? ) -> LazyParagraph? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyParagraph()
    
    object.alignment = left?.alignment + right?.alignment
    
    object.lineBreakMode = left?.lineBreakMode + right?.lineBreakMode
    
    object.lineSpacing = left?.lineSpacing + right?.lineSpacing
    
    object.paragraphSpacing = left?.paragraphSpacing + right?.paragraphSpacing
    
    object.headIndent = left?.headIndent + right?.headIndent
    
    return object
}
