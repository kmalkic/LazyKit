//
//  TextSet.swift
//  LazyKit
//
//  Created by Malkic Kevin on 22/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

let kFullFontKey            = "font"
let kTextColorKey           = "color"
let kFontNameKey            = "font-family"
let kFontSizeKey            = "font-size"
let kAlignmentSizeKey       = "text-align"
let kLineSpacingKey         = "line-height"
let kParagraphSpacingKey    = "paragraph-spacing"
let kHeadIndentKey          = "text-indent"
let kWordWrapKey            = "word-wrap"

let kTextStrokeWidthKey     = "text-stroke-width"
let kTextStrokeColorKey     = "text-stroke-color"
let kTextDecorationKey      = "text-decoration"
let kTextDecorationColorKey = "text-decoration-color"

class LazyTextSet {
 
    var fontObj: LazyFont?
    var textColor: LazyColor?
    var textalignment: LazyTextalignment?
    var paragraph: LazyParagraph?
    var textStroke: LazyTextStroke?
    var textDecoration: LazyTextDecoration?
    
    init() {
        
    }
    
    private func fetchFont() -> LazyFont! {
        if fontObj == nil {
            fontObj = LazyFont()
        }
        return fontObj!
    }
    
    private func fetchParagraph() -> LazyParagraph! {
        if paragraph == nil {
            paragraph = LazyParagraph()
        }
        return paragraph!
    }
    
    private func fetchTextStroke() -> LazyTextStroke! {
        if textStroke == nil {
            textStroke = LazyTextStroke()
        }
        return textStroke!
    }
    
    private func fetchTextDecoration() -> LazyTextDecoration! {
        if textDecoration == nil {
            textDecoration = LazyTextDecoration()
        }
        return textDecoration!
    }
    
    func hasTextAttributes() -> Bool {
        return textColor != nil || fontObj != nil || textalignment != nil
    }
    
    func textAttributes() -> [String: AnyObject]! {

        var textAttributes = [String: AnyObject]()
        
        if textColor != nil {
            textAttributes[NSForegroundColorAttributeName] = textColor!.color()
        }
        if fontObj != nil {
            textAttributes[NSFontAttributeName] = fontObj!.font()
        }
        if textalignment != nil {
            fetchParagraph().alignment = textalignment!.alignment!
        }
        if paragraph != nil {
            textAttributes[NSParagraphStyleAttributeName] = paragraph!.paragraphStyle()
        }
        if textStroke?.width != nil {
            textAttributes[NSStrokeWidthAttributeName] = (textStroke!.width!.value)
        }
        if textStroke?.color != nil {
            textAttributes[NSStrokeColorAttributeName] = textStroke!.color!.color()
        }
        if textDecoration?.underline == true {
            textAttributes[NSUnderlineStyleAttributeName] = (1)
            if textDecoration?.color != nil {
                textAttributes[NSUnderlineColorAttributeName] = textDecoration!.color!.color()
            }
        }
        if textDecoration?.strikethrough == true {
            textAttributes[NSStrikethroughStyleAttributeName] = (1)
            if textDecoration?.color != nil {
                textAttributes[NSStrikethroughColorAttributeName] = textDecoration!.color!.color()
            }
        }
        
        return textAttributes
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
    
            case kTextColorKey:
                textColor = LazyColor(anyString: value)
                
            case kFontNameKey:
                fetchFont().fontName = fetchFont().parseFontNames(value)
                
            case kFontSizeKey:
                fetchFont().fontSize = LazyMeasure(string: value)
                
            case kAlignmentSizeKey:
                textalignment = LazyTextalignment(string: value)
                
            case kLineSpacingKey:
                fetchParagraph().lineSpacing = LazyMeasure(string: value)
                
            case kParagraphSpacingKey:
                fetchParagraph().paragraphSpacing = LazyMeasure(string: value)
                
            case kHeadIndentKey:
                fetchParagraph().headIndent = LazyMeasure(string: value)
                
            case kWordWrapKey:
                fetchParagraph().lineBreakMode = fetchParagraph().convertWordWrap(value)

            case kTextStrokeWidthKey:
                fetchTextStroke().width = LazyMeasure(string: value)
                
            case kTextStrokeColorKey:
                fetchTextStroke().color = LazyColor(anyString: value)
                
            case kTextDecorationKey:
                fetchTextDecoration().setup(value)
                
            case kTextDecorationColorKey:
                fetchTextDecoration().color = LazyColor(anyString: value)
            
            default:
                break
            }
        }
        
        if isPropertiesNil() {
            return nil
        }
    }
    
    func isPropertiesNil() -> Bool {
        return fontObj == nil && textColor == nil && textalignment == nil && paragraph == nil && textStroke == nil && textDecoration == nil
    }
}

func + (left:LazyTextSet?, right:LazyTextSet? ) -> LazyTextSet? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyTextSet()
    
    object.fontObj = left?.fontObj + right?.fontObj
    
    object.textalignment = left?.textalignment + right?.textalignment
    
    object.textColor = left?.textColor + right?.textColor
    
    object.paragraph = left?.paragraph + right?.paragraph
    
    object.textStroke = left?.textStroke + right?.textStroke
    
    object.textDecoration = left?.textDecoration + right?.textDecoration
    
    return object
}
