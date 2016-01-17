//
//  MyCellConfigurations.swift
//  LazyKitDemo
//
//  Created by Kevin Malkic on 17/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit
import LazyKit

struct MyCellConfigurations: LazyViewConfigurations {

    static func elementsOptions() -> [ElementOptions]? {
        
        return [
            LabelOptions(identifier: "title",
                textOptions: TextBaseOptions(text: "title", font: .systemFontOfSize(16), textAlignment: .Left)
            ),
            
            LabelOptions(identifier: "subtitle",
                textOptions: TextBaseOptions(text: "subtitle", font: .systemFontOfSize(12), textAlignment: .Left)
            ),
            
            ImageOptions(identifier: "photo",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .lightGrayColor()),
                imageBaseOptions: ImageBaseOptions(imageNamed: "image", contentMode: .ScaleAspectFill)
            )
        ]
    }
    
    static func visualFormatConstraintOptions() -> [VisualFormatConstraintOptions]? {
        
        return [
            VisualFormatConstraintOptions(string: "H:|[photo(==photoW)]-[title]-|"),
            VisualFormatConstraintOptions(string: "H:[subtitle(==title)]"),
            VisualFormatConstraintOptions(string: "V:|[title][subtitle]|", options: .AlignAllLeft),
            VisualFormatConstraintOptions(string: "V:|[photo]|")
        ]
    }
    
    static func visualFormatMetrics() -> [String: AnyObject]? {
        
        return ["photoW" : 80]
    }
    
    static func layoutConstraints() -> [ConstraintOptions]? {
        
        return nil
    }
}
