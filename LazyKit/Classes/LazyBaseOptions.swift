//
//  LazyBaseOptions.swift
//  LazyKit
//
//  Created by Kevin Malkic on 17/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

//MARK: Base options

public protocol BaseOptions {
    
}

public struct ViewBaseOptions: BaseOptions {
    
    public var accessibilityIdentifier: String?
    public var backgroundColor: UIColor?
    public var tintColor: UIColor?
    
    public init(accessibilityIdentifier: String? = nil, backgroundColor: UIColor? = nil, tintColor: UIColor? = nil) {
        
        self.accessibilityIdentifier = accessibilityIdentifier
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
    }
}

public struct TextBaseOptions: BaseOptions {
    
    public var text: String?
    public var font: UIFont?
    public var textColor: UIColor?
    public var textAlignment: NSTextAlignment?
    public var numberOfLines: Int?
    public var adjustsFontSizeToFitWidth: Bool?
    
    public var lineSpacing: CGFloat?
    public var paragraphSpacing: CGFloat?
    public var headIndent: CGFloat?
    public var lineBreakMode: NSLineBreakMode?
    
    public init(text: String? = nil, font: UIFont? = nil, textColor: UIColor? = nil, textAlignment: NSTextAlignment? = nil, numberOfLines: Int? = nil, adjustsFontSizeToFitWidth: Bool? = nil, lineSpacing: CGFloat? = nil, paragraphSpacing: CGFloat? = nil, headIndent: CGFloat? = nil, lineBreakMode: NSLineBreakMode? = nil) {
        
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.lineSpacing = lineSpacing
        self.paragraphSpacing = paragraphSpacing
        self.headIndent = headIndent
        self.lineBreakMode = lineBreakMode
    }
}

public struct ImageBaseOptions: BaseOptions {
    
    public var contentMode: UIViewContentMode?
    public var tintColor: UIColor?
    public var imageNamed: String?
    
    public init(imageNamed: String? = nil, contentMode: UIViewContentMode? = nil, tintColor: UIColor? = nil) {
        
        self.tintColor = tintColor
        self.contentMode = contentMode
        self.imageNamed = imageNamed
    }
}

public struct TextInputBaseOptions: BaseOptions {
    
    public var autocapitalizationType: UITextAutocapitalizationType?
    public var autocorrectionType: UITextAutocorrectionType?
    public var spellCheckingType: UITextSpellCheckingType?
    public var keyboardType: UIKeyboardType?
    public var keyboardAppearance: UIKeyboardAppearance?
    public var returnKeyType: UIReturnKeyType?
    public var enablesReturnKeyAutomatically: Bool?
    public var secureTextEntry: Bool?
    
    public init(autocapitalizationType: UITextAutocapitalizationType? = nil, autocorrectionType: UITextAutocorrectionType? = nil, spellCheckingType: UITextSpellCheckingType? = nil, keyboardType: UIKeyboardType? = nil, keyboardAppearance: UIKeyboardAppearance? = nil, returnKeyType: UIReturnKeyType? = nil, enablesReturnKeyAutomatically: Bool? = nil, secureTextEntry: Bool? = nil) {
        
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.spellCheckingType = spellCheckingType
        self.keyboardType = keyboardType
        self.keyboardAppearance = keyboardAppearance
        self.returnKeyType = returnKeyType
        self.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        self.secureTextEntry = secureTextEntry
    }
}


func + (left:ViewBaseOptions?, right:ViewBaseOptions? ) -> ViewBaseOptions? {
    
    if left == nil && right == nil { return nil }
    
    var object = ViewBaseOptions()
    object.accessibilityIdentifier  = right?.accessibilityIdentifier ?? left?.accessibilityIdentifier
    object.backgroundColor  = right?.backgroundColor ?? left?.backgroundColor
    object.tintColor  = right?.tintColor ?? left?.tintColor
    
    return object
}

func + (left:TextBaseOptions?, right:TextBaseOptions? ) -> TextBaseOptions? {
    
    if left == nil && right == nil { return nil }
    
    var object = TextBaseOptions()
    object.text  = right?.text ?? left?.text
    object.font  = right?.font ?? left?.font
    object.textColor  = right?.textColor ?? left?.textColor
    object.textAlignment  = right?.textAlignment ?? left?.textAlignment
    object.numberOfLines  = right?.numberOfLines ?? left?.numberOfLines
    object.adjustsFontSizeToFitWidth  = right?.adjustsFontSizeToFitWidth ?? left?.adjustsFontSizeToFitWidth
    object.lineSpacing  = right?.lineSpacing ?? left?.lineSpacing
    object.paragraphSpacing  = right?.paragraphSpacing ?? left?.paragraphSpacing
    object.headIndent  = right?.headIndent ?? left?.headIndent
    object.lineBreakMode  = right?.lineBreakMode ?? left?.lineBreakMode
    
    return object
}

func + (left:[UIControlState: TextBaseOptions]?, right:[UIControlState: TextBaseOptions]? ) -> [UIControlState: TextBaseOptions]? {
    
    return right ?? left
}

func + (left:ImageBaseOptions?, right:ImageBaseOptions? ) -> ImageBaseOptions? {
    
    if left == nil && right == nil { return nil }
    
    var object = ImageBaseOptions()
    object.tintColor  = right?.tintColor ?? left?.tintColor
    object.contentMode  = right?.contentMode ?? left?.contentMode
    object.imageNamed  = right?.imageNamed ?? left?.imageNamed
    
    return object
}
