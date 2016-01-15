//
//  Extensions.swift
//  LazyKit
//
//  Created by Kevin Malkic on 15/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

extension UIControlState: Hashable {
    
    public var hashValue: Int {
        
        return Int(rawValue)
    }
}
