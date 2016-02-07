//
//  LazyBaseOptions.swift
//  LazyKit
//
//  Created by Kevin Malkic on 17/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

//MARK: - Base options

///Structure for UIView base properties
public struct ViewBaseOptions {
    
    /**
     A string that identifies the element.
     */
    public var accessibilityIdentifier: String?
    /**
     The view’s background color.
     */
    public var backgroundColor: UIColor?
    /**
     The first nondefault tint color value in the view’s hierarchy, ascending from and starting with the view itself.
     */
    public var tintColor: UIColor?
    /**
     The view’s alpha value.
     */
    public var alpha: CGFloat?
    /**
     The width of the layer’s border.
     */
    public var borderWidth: CGFloat?
    /**
     The color of the layer’s border.
     */
    public var borderColor: UIColor?
    /**
     The radius of curvature for the plane’s corners.
     */
    public var cornerRadius: CGFloat?
    
    /**
     Constructor
     */
    public init(accessibilityIdentifier: String? = nil, backgroundColor: UIColor? = nil, tintColor: UIColor? = nil, alpha: CGFloat? = nil, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil, cornerRadius: CGFloat? = nil) {
        
        self.accessibilityIdentifier = accessibilityIdentifier
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.alpha = alpha
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
    }
}

///Structure for UI elements that support UILabel base properties
public struct TextBaseOptions {
    
    /**
     The text displayed by the label.
     */
    public var text: String?
    /**
     The font of the text.
     */
    public var font: UIFont?
    /**
     The color of the text.
     */
    public var textColor: UIColor?
    /**
     The technique to use for aligning the text.
     */
    public var textAlignment: NSTextAlignment?
    /**
     The maximum number of lines to use for rendering text.
     */
    public var numberOfLines: Int?
    /**
     A Boolean value indicating whether the font size should be reduced in order to fit the title string into the label’s bounding rectangle.
     */
    public var adjustsFontSizeToFitWidth: Bool?
    /**
     The distance in points between the bottom of one line fragment and the top of the next.
     */
    public var lineSpacing: CGFloat?
    /**
     The space after the end of the paragraph.
     */
    public var paragraphSpacing: CGFloat?
    /**
     The indentation of the receiver’s lines other than the first.
     */
    public var headIndent: CGFloat?
    /**
     The mode that should be used to break lines in the receiver.
     */
    public var lineBreakMode: NSLineBreakMode?
    
    /**
     Constructor
     */
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

///Structure for UI elements that support UIImageView base properties
public struct ImageBaseOptions {
    
    /**
     A flag used to determine how a view lays out its content when its bounds change.
     */
    public var contentMode: UIViewContentMode?
    /**
     A color used to tint template images in the view hierarchy.
     */
    public var tintColor: UIColor?
    /**
     The name of the file. If this is the first time the image is being loaded, the method looks for an image with the specified name in the application’s main bundle.
     */
    public var imageNamed: String?
    
    /**
     Constructor
     */
    public init(imageNamed: String? = nil, contentMode: UIViewContentMode? = nil, tintColor: UIColor? = nil) {
        
        self.tintColor = tintColor
        self.contentMode = contentMode
        self.imageNamed = imageNamed
    }
}

///Structure for UI elements that support Text inputs
public struct TextInputBaseOptions {
    
    /**
     The auto-capitalization style for the text object.
     */
    public var autocapitalizationType: UITextAutocapitalizationType?
    /**
     The autocorrection style for the text object.
     */
    public var autocorrectionType: UITextAutocorrectionType?
    /**
     The spell-checking style for the text object.
     */
    public var spellCheckingType: UITextSpellCheckingType?
    /**
     The keyboard style associated with the text object.
     */
    public var keyboardType: UIKeyboardType?
    /**
     The appearance style of the keyboard that is associated with the text object
     */
    public var keyboardAppearance: UIKeyboardAppearance?
    /**
     The visible title of the Return key.
     */
    public var returnKeyType: UIReturnKeyType?
    /**
     A Boolean value indicating whether the Return key is automatically enabled when the user is entering text.
     */
    public var enablesReturnKeyAutomatically: Bool?
    /**
     Identifies whether the text object should hide the text being entered.
     */
    public var secureTextEntry: Bool?
    
    /**
     Constructor
     */
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

//MARK: - Operands

internal func + (left:ViewBaseOptions?, right:ViewBaseOptions? ) -> ViewBaseOptions? {
    
    if left == nil && right == nil { return nil }
    
    var object = ViewBaseOptions()
    object.accessibilityIdentifier  = right?.accessibilityIdentifier ?? left?.accessibilityIdentifier
    object.backgroundColor  = right?.backgroundColor ?? left?.backgroundColor
    object.tintColor  = right?.tintColor ?? left?.tintColor
    object.alpha = right?.alpha ?? left?.alpha
    object.borderWidth = right?.borderWidth ?? left?.borderWidth
    object.borderColor = right?.borderColor ?? left?.borderColor
    object.cornerRadius = right?.cornerRadius ?? left?.cornerRadius
    
    return object
}

internal func + (left:TextBaseOptions?, right:TextBaseOptions? ) -> TextBaseOptions? {
    
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

internal func + (left:[LazyControlState: TextBaseOptions]?, right:[LazyControlState: TextBaseOptions]? ) -> [LazyControlState: TextBaseOptions]? {
    
    return right ?? left
}

internal func + (left:[LazyControlState: ImageBaseOptions]?, right:[LazyControlState: ImageBaseOptions]? ) -> [LazyControlState: ImageBaseOptions]? {
    
    return right ?? left
}

internal func + (left:ImageBaseOptions?, right:ImageBaseOptions? ) -> ImageBaseOptions? {
    
    if left == nil && right == nil { return nil }
    
    var object = ImageBaseOptions()
    object.tintColor  = right?.tintColor ?? left?.tintColor
    object.contentMode  = right?.contentMode ?? left?.contentMode
    object.imageNamed  = right?.imageNamed ?? left?.imageNamed
    
    return object
}
