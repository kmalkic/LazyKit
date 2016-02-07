//
//  TextSet.swift
//  LazyKit
//
//  Created by Malkic Kevin on 22/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal let kFullFontKey            = "font"
internal let kTextColorKey           = "color"
internal let kFontNameKey            = "font-family"
internal let kFontSizeKey            = "font-size"
internal let kAlignmentSizeKey       = "text-align"
internal let kLineSpacingKey         = "line-height"
internal let kParagraphSpacingKey    = "paragraph-spacing"
internal let kHeadIndentKey          = "text-indent"
internal let kWordWrapKey            = "word-wrap"
internal let kNumberOfLinesKey       = "text-maxline"

internal let kTextStrokeWidthKey     = "text-stroke-width"
internal let kTextStrokeColorKey     = "text-stroke-color"
internal let kTextDecorationKey      = "text-decoration"
internal let kTextDecorationColorKey = "text-decoration-color"

internal enum TextSearchMode: String {

    case Normal = ""
    case Placeholder = "placeholder-"
}

internal class LazyTextSet {
 
    var fontObj: LazyFont?
    var textColor: LazyColor?
    var textAlignment: LazyTextAlignment?
    var paragraph: LazyParagraph?
    var textStroke: LazyTextStroke?
    var textDecoration: LazyTextDecoration?
    var numberOfLines: LazyInt?
    
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
		
        return textColor != nil || fontObj != nil || textAlignment != nil
    }
    
    func textAttributes() -> [String: AnyObject]! {

        var textAttributes = [String: AnyObject]()
        
        if textColor != nil {
			
            textAttributes[NSForegroundColorAttributeName] = textColor!.color()
        }
		
        if fontObj != nil {
			
            textAttributes[NSFontAttributeName] = fontObj!.font()
        }
		
        if textAlignment != nil {
			
            fetchParagraph().alignment = textAlignment!
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
    
    init?(content: [String]!, variables: [String: String]?, textSearchMode: TextSearchMode = .Normal) {
        
        let prefix = textSearchMode.rawValue
        
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
			
			if let variables = variables {
				
				value = variables[rawValue] ?? rawValue
			}
			
            switch key {
    
            case prefix + kTextColorKey:
                textColor = LazyColor(anyString: value)
                
            case prefix + kFontNameKey:
                fetchFont().fontName = fetchFont().parseFontNames(value)
                
            case prefix + kFontSizeKey:
                fetchFont().fontSize = LazyMeasure(string: value)
                
            case prefix + kAlignmentSizeKey:
                textAlignment = LazyTextAlignment(string: value)
                
            case prefix + kLineSpacingKey:
                fetchParagraph().lineSpacing = LazyMeasure(string: value)
                
            case prefix + kParagraphSpacingKey:
                fetchParagraph().paragraphSpacing = LazyMeasure(string: value)
                
            case prefix + kHeadIndentKey:
                fetchParagraph().headIndent = LazyMeasure(string: value)
                
            case prefix + kWordWrapKey:
                fetchParagraph().lineBreakMode = fetchParagraph().convertWordWrap(value)

            case prefix + kTextStrokeWidthKey:
                fetchTextStroke().width = LazyMeasure(string: value)
                
            case prefix + kTextStrokeColorKey:
                fetchTextStroke().color = LazyColor(anyString: value)
                
            case prefix + kTextDecorationKey:
                fetchTextDecoration().setup(value)
                
            case prefix + kTextDecorationColorKey:
                fetchTextDecoration().color = LazyColor(anyString: value)
            
            case prefix + kNumberOfLinesKey:
                numberOfLines = (value as NSString).integerValue
                
            default:
                break
            }
        }
        
        if isPropertiesNil() {
            
            return nil
        }
    }
    
    func isPropertiesNil() -> Bool {
        
        return fontObj == nil && textColor == nil && textAlignment == nil && paragraph == nil && textStroke == nil && textDecoration == nil && numberOfLines == nil
    }
}
