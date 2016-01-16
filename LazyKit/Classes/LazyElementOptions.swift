//
//  ElementOptions.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
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
    
    public init(text: String? = nil, font: UIFont? = nil, textColor: UIColor? = nil, textAlignment: NSTextAlignment? = nil, numberOfLines: Int? = nil, adjustsFontSizeToFitWidth: Bool? = nil) {
        
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
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

//MARK: Element options

public protocol ElementOptions {
    
    var identifier: String? { get set }
    var viewBaseOptions: ViewBaseOptions? { get set }
}

public struct ViewOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UIView.self
    public var viewBaseOptions: ViewBaseOptions?
    
    public init(identifier: String? = nil, classType: UIView.Type = UIView.self, viewBaseOptions: ViewBaseOptions? = nil) {
        
        self.identifier = identifier
        self.viewBaseOptions = viewBaseOptions
        self.classType = classType
    }
}

public struct LabelOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UILabel.self
    public var viewBaseOptions: ViewBaseOptions?
    public let textOptions: TextBaseOptions?
    
    public init(identifier: String? = nil, classType: UILabel.Type = UILabel.self, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil) {
        
        self.identifier = identifier
        self.viewBaseOptions = viewBaseOptions
        self.textOptions = textOptions
        self.classType = classType
    }
}

public struct ButtonOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UIButton.self
    public var viewBaseOptions: ViewBaseOptions?
    public let textOptionsForType: [UIControlState: TextBaseOptions]?
    
    public let type: UIButtonType
    
    public init(identifier: String? = nil, classType: UIButton.Type = UIButton.self, type: UIButtonType = .Custom, viewBaseOptions: ViewBaseOptions? = nil, textOptionsForType: [UIControlState: TextBaseOptions]? = nil) {
        
        self.identifier = identifier
        self.viewBaseOptions = viewBaseOptions
        self.textOptionsForType = textOptionsForType
        self.type = type
        self.classType = classType
    }
}

public struct ImageOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UIImageView.self
    public var viewBaseOptions: ViewBaseOptions?
    public let imageBaseOptions: ImageBaseOptions?
    
    public init(identifier: String? = nil, classType: UIImageView.Type = UIImageView.self, viewBaseOptions: ViewBaseOptions? = nil, imageBaseOptions: ImageBaseOptions? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.viewBaseOptions = viewBaseOptions
        self.imageBaseOptions = imageBaseOptions
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
