//
//  LazyConstraintOptions.swift
//  LazyKit
//
//  Created by Kevin Malkic on 17/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

//MARK: - Layout constraints options

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
