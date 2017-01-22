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
                textOptions: TextBaseOptions(text: "title", font: .systemFont(ofSize: 16), textAlignment: .left)
            ),
            
            LabelOptions(identifier: "subtitle",
                textOptions: TextBaseOptions(text: "subtitle", font: .systemFont(ofSize: 12), textAlignment: .left)
            ),
            
            ImageOptions(identifier: "photo",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .lightGray),
                imageBaseOptions: ImageBaseOptions(imageNamed: "image", contentMode: .scaleAspectFill)
            )
        ]
    }
    
    static func visualFormatConstraintOptions() -> [VisualFormatConstraintOptions]? {
        
        return [
            VisualFormatConstraintOptions(string: "H:|[photo(==photoW)]-[title]-|"),
            VisualFormatConstraintOptions(string: "H:[subtitle(==title)]"),
            VisualFormatConstraintOptions(string: "V:|[title][subtitle]|", options: .alignAllLeft),
            VisualFormatConstraintOptions(string: "V:|[photo]|")
        ]
    }
    
    static func visualFormatMetrics() -> [String: AnyObject]? {
        
        return ["photoW" : 80 as AnyObject]
    }
    
    static func layoutConstraints() -> [ConstraintOptions]? {
        
        return nil
    }
}
