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
    
    public let accessibilityIdentifier: String?
    public let backgroundColor: UIColor?
    public let tintColor: UIColor?
    
    public init(accessibilityIdentifier: String? = nil, backgroundColor: UIColor? = nil, tintColor: UIColor? = nil) {
        
        self.accessibilityIdentifier = accessibilityIdentifier
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
    }
}

public struct TextBaseOptions: BaseOptions {
    
    public let text: String?
    public let font: UIFont?
    public let textColor: UIColor?
    public let textAlignment: NSTextAlignment?
    public let numberOfLines: Int?
    public let adjustsFontSizeToFitWidth: Bool?
    
    public let lineSpacing: CGFloat?
    public let paragraphSpacing: CGFloat?
    public let headIndent: CGFloat?
    public let lineBreakMode: NSLineBreakMode?
    
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
    
    public let contentMode: UIViewContentMode?
    public let tintColor: UIColor?
    public let imageNamed: String?
    
    public init(imageNamed: String? = nil, contentMode: UIViewContentMode? = nil, tintColor: UIColor? = nil) {
        
        self.tintColor = tintColor
        self.contentMode = contentMode
        self.imageNamed = imageNamed
    }
}

public struct TextInputBaseOptions: BaseOptions {
    
    public let autocapitalizationType: UITextAutocapitalizationType?
    public let autocorrectionType: UITextAutocorrectionType?
    public let spellCheckingType: UITextSpellCheckingType?
    public let keyboardType: UIKeyboardType?
    public let keyboardAppearance: UIKeyboardAppearance?
    public let returnKeyType: UIReturnKeyType?
    public let enablesReturnKeyAutomatically: Bool?
    public let secureTextEntry: Bool?
    
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