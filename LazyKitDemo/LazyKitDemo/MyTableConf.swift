//
//  MyTableConf.swift
//  LazyKitDemo
//
//  Created by Kevin Malkic on 17/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit
import LazyKit

struct MyTableConfigurations: LazyViewConfigurations {

    static func elementsOptions() -> [ElementOptions]? {
        
        return [
            TableViewOptions(identifier: "tableView",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .whiteColor())
            )
        ]
    }
	
    static func visualFormatConstraintOptions() -> [VisualFormatConstraintOptions]? {
        
        return [
            VisualFormatConstraintOptions(string: "H:|[tableView]|"),
            VisualFormatConstraintOptions(string: "V:|-20-[tableView]|"),
        ]
    }
    
    static func visualFormatMetrics() -> [String: AnyObject]? {
        
        return nil
    }
    
    static func layoutConstraints() -> [ConstraintOptions]? {
        
        return nil
    }
}
