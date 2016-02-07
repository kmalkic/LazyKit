//
//  LazyBaseProtocols.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

/// Protocol that act like a dataSource to provide information on views properties and constraints.
public protocol LazyViewConfigurations {
    
    /**
     View configurations
     
     - returns: An array of objects that conform to ElementOptions protocol
     */
    static func elementsOptions() -> [ElementOptions]?
    /**
     An array of visual format constraint objects.
     
     - returns: An array of visual format constraint objects.
     */
    static func visualFormatConstraintOptions() -> [VisualFormatConstraintOptions]?
    /**
     An array of metrics to be used by visual format constraint objects.
     
     - returns: An array of metrics to be used by visual format constraint objects.
     */
    static func visualFormatMetrics() -> [String: AnyObject]?
    /**
     An array of an abtraction of classic constraints using identifiers instead of references.
     
     - returns: An array of constraint options.
     */
    static func layoutConstraints() -> [ConstraintOptions]?
}

/// Protocol that provide extra optional functions
public protocol LazyViewConfigurationsOptions {
    
    /**
     For optimisation purposes, after an update was triggered you can make the system not recreate elements of the view.
     
     - returns: true or false // return true by default
     */
    static func shouldRecreateAllElementsAfterUpdatePosted() -> Bool
}
