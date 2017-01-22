//
//  LazyParagraph.swift
//  LazyKit
//
//  Created by Kevin Malkic on 28/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal class LazyParagraph {
    
    var lineSpacing: LazyMeasure?
    
    var paragraphSpacing: LazyMeasure?
    
    var headIndent: LazyMeasure?
    
    var alignment: LazyTextAlignment?
    
    var lineBreakMode: LazyLineBreakMode?
    
    func convertWordWrap(_ wordWrap: String) -> NSLineBreakMode {
        
        switch wordWrap {
			
        case "word-wrapping":
            return .byWordWrapping
			
        case "char-wrapping":
            return .byCharWrapping
			
        case "clipping":
            return .byClipping
			
        case "truncating-head":
            return .byTruncatingHead
			
        case "truncating-tail":
            return .byTruncatingTail
			
        case "truncating-middle":
            return .byTruncatingMiddle
			
        default:
            break
        }
		
        return .byTruncatingTail
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
            
            paragraphStyle.alignment = value.alignment!
            
        } else {
            
            paragraphStyle.alignment = .left
        }
        
        if let value = lineBreakMode {
            
            paragraphStyle.lineBreakMode = value
            
        } else {
            
            paragraphStyle.lineBreakMode = .byTruncatingTail
        }
        
        return paragraphStyle
    }
}
