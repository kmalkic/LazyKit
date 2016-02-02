//
//  LazyBaseProtocols.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

public protocol LazyViewConfigurations {
    
    static func elementsOptions() -> [ElementOptions]?
    static func visualFormatConstraintOptions() -> [VisualFormatConstraintOptions]?
    static func visualFormatMetrics() -> [String: AnyObject]?
    static func layoutConstraints() -> [ConstraintOptions]?
}

public protocol LazyViewConfigurationsOptions {
    
    static func shouldNotRecreateAllElementsAfterUpdatePosted() -> Bool
}
