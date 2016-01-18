//
//  UIColor+LazyKit.swift
//  LazyKit
//
//  Created by Kevin Malkic on 02/05/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

extension UIColor {
 
    public func red() -> CGFloat {
        let components = CGColorGetComponents(self.CGColor)
        return components[0]
    }
    
    public func blue() -> CGFloat {
        let components = CGColorGetComponents(self.CGColor)
        return components[2]
    }
    
    public func green() -> CGFloat {
        let components = CGColorGetComponents(self.CGColor)
        return components[1]
    }
    
    public func alpha() -> CGFloat {
        let components = CGColorGetComponents(self.CGColor)
        return components[3]
    }
    
    public class func random() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
    }
}
