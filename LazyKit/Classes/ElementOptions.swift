//
//  ElementOptions.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

//MARK: Base options

public struct ViewBaseOptions {
    
    public let identifier: String?
    public let accessibilityIdentifier: String?
    public let backgroundColor: UIColor
    
    public init(identifier: String? = nil, accessibilityIdentifier: String? = nil, backgroundColor: UIColor = .clearColor()) {
        
        self.identifier = identifier
        self.accessibilityIdentifier = accessibilityIdentifier
        self.backgroundColor = backgroundColor
    }
}

public struct TextBaseOptions {
    
    public let text: String?
    public let font: UIFont
    public let textColor: UIColor
    public let textAlignment: NSTextAlignment
    public let numberOfLines: Int
    public let adjustsFontSizeToFitWidth: Bool
    
    public init(text: String? = nil, font: UIFont = .systemFontOfSize(12), textColor: UIColor = .blackColor(), textAlignment: NSTextAlignment = .Left, numberOfLines: Int = 1, adjustsFontSizeToFitWidth: Bool = false) {
        
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
    }
}

//MARK: Element options

public protocol ElementOptions {
    
    var viewOptions: ViewBaseOptions { get set }
}

public struct LabelOptions : ElementOptions {
    
    public var viewOptions: ViewBaseOptions
    public let textOptions: TextBaseOptions
    
    public init(viewOptions: ViewBaseOptions, textOptions: TextBaseOptions) {
        
        self.viewOptions = viewOptions
        self.textOptions = textOptions
    }
}

public struct ButtonOptions : ElementOptions {
    
    public var viewOptions: ViewBaseOptions
    public let normalTextOptions: TextBaseOptions?
    public let highlightTextOptions: TextBaseOptions?
    public let selectedTextOptions: TextBaseOptions?
    public let disabledTextOptions: TextBaseOptions?
    
    public let type: UIButtonType
    
    public init(type: UIButtonType = .Custom,viewOptions: ViewBaseOptions, normalTextOptions: TextBaseOptions? = nil, highlightTextOptions: TextBaseOptions? = nil, selectedTextOptions: TextBaseOptions? = nil, disabledTextOptions: TextBaseOptions? = nil) {
        
        self.viewOptions = viewOptions
        self.normalTextOptions = normalTextOptions
        self.highlightTextOptions = highlightTextOptions
        self.selectedTextOptions = selectedTextOptions
        self.disabledTextOptions = disabledTextOptions
        self.type = type
    }
}

//MARK: Layout constraints options

public struct VisualFormatConstraintOptions {
    
    public var identifier: String?
    public let string: String
    public let options: NSLayoutFormatOptions
    
    public init(identifier: String? = nil, string: String, options: NSLayoutFormatOptions = NSLayoutFormatOptions(rawValue: 0)) {
        
        self.identifier = identifier
        self.string = string
        self.options = options
    }
}

public struct ConstraintOptions {
    
    public var identifier: String?
    public let identifier1: String
    public let identifier2: String?
    public let attribute1: NSLayoutAttribute
    public let attribute2: NSLayoutAttribute
    public let relatedBy: NSLayoutRelation
    public let multiplier: CGFloat
    public let constant: CGFloat
    
    public init(identifier: String? = nil, itemIdentifier identifier1: String, attribute attr1: NSLayoutAttribute, relatedBy relation: NSLayoutRelation, toItemIdentifier identifier2: String?, attribute attr2: NSLayoutAttribute, multiplier: CGFloat, constant c: CGFloat) {
        
        self.identifier = identifier
        self.identifier1 = identifier1
        self.identifier2 = identifier2
        self.attribute1 = attr1
        self.attribute2 = attr2
        self.relatedBy = relation
        self.multiplier = multiplier
        self.constant = c
    }
}
