//
//  LazyConstraintOptions.swift
//  LazyKit
//
//  Created by Kevin Malkic on 17/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

//MARK: - Layout constraints options

///Structure to map visual format constraints
public struct VisualFormatConstraintOptions {
    
    /**
     A string that identifies the set of constraints.
     */
    public var identifier: String?
    /**
     The format specification for the constraints. For more information, see Visual Format Language in Auto Layout Guide.
     */
    public let string: String
    /**
     Options describing the attribute and the direction of layout for all objects in the visual format string.
     */
    public let options: NSLayoutFormatOptions
	
	/**
	Constructor
	*/
    public init(identifier: String? = nil, string: String, options: NSLayoutFormatOptions = NSLayoutFormatOptions(rawValue: 0)) {
        
        self.identifier = identifier
        self.string = string
        self.options = options
    }
}

///Structure to map layout constraints
public struct ConstraintOptions {
    
    /**
     A string that identifies the layout.
     */
    public var identifier: String?
    /**
     A string that identifies the element for the left side of the constraint.
     */
    public let identifier1: String
    /**
     A string that identifies the element for the right side of the constraint.
     */
    public let identifier2: String?
    /**
     The attribute of the view for the left side of the constraint.
     */
    public let attribute1: NSLayoutAttribute
    /**
     The attribute of the view for the right side of the constraint.
     */
    public let attribute2: NSLayoutAttribute
    /**
     The relationship between the left side of the constraint and the right side of the constraint.
     */
    public let relatedBy: NSLayoutRelation
    /**
     The constant multiplied with the attribute on the right side of the constraint as part of getting the modified attribute.
     */
    public let multiplier: CGFloat
    /**
     The constant added to the multiplied attribute value on the right side of the constraint to yield the final modified attribute.
     */
    public let constant: CGFloat
	
	/**
	 Constructor
	*/
	public init(identifier: String? = nil, itemIdentifier identifier1: String, attribute attr1: NSLayoutAttribute, relatedBy relation: NSLayoutRelation, toItemIdentifier identifier2: String? = nil, toSuperview useSuperview: Bool = false, attribute attr2: NSLayoutAttribute, multiplier: CGFloat, constant c: CGFloat) {
        
        self.identifier = identifier
        self.identifier1 = identifier1
		self.identifier2 = (useSuperview) ? "superview" : identifier2
        self.attribute1 = attr1
        self.attribute2 = attr2
        self.relatedBy = relation
        self.multiplier = multiplier
        self.constant = c
    }
}
