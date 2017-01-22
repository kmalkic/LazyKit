//
//  MyConfigurations.swift
//  LazyKitDemo
//
//  Created by Kevin Malkic on 16/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit
import LazyKit

struct MyCssConfigurations: LazyViewConfigurations, LazyViewConfigurationsOptions {
    
    static func elementsOptions() -> [ElementOptions]? {
        
        return [
            
            LabelOptions(identifier: "title",
                text: "hello",
                styleId: "title"),
            
            LabelOptions(identifier: "subtitle",
                text: "hey",
                styleId: "subtitle"),
            
            ButtonOptions(identifier: "button",
                texts: [.Normal: "button", .Highlighted: "highlighted"],
                styleId: "button"),
            
            ViewOptions(identifier: "line",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .lightGray)),
            
            ImageOptions(identifier: "photo",
                styleId: "photo",
                styleClass: "photo"),
            
            TextFieldOptions(identifier: "textfield",
                placeholderText: "placeholder",
                styleId: "textfield",
                textInputOptions: TextInputBaseOptions(autocapitalizationType: .sentences, autocorrectionType: .no, spellCheckingType: .no, keyboardType: .numbersAndPunctuation, keyboardAppearance: .dark, returnKeyType: .done)),
            
            TextViewOptions(identifier: "textview",
                styleId: "textview",
                textInputOptions: TextInputBaseOptions(autocapitalizationType: .sentences, autocorrectionType: .no, spellCheckingType: .no, keyboardType: .emailAddress, keyboardAppearance: .dark, returnKeyType: .done)
            )
        ]
    }
    
    static func visualFormatConstraintOptions() -> [VisualFormatConstraintOptions]? {
        
        return [
            VisualFormatConstraintOptions(string: "H:|-[photo(==photoW)]-[title]-|"),
            VisualFormatConstraintOptions(string: "H:[subtitle(==title)]"),
            VisualFormatConstraintOptions(string: "H:[textfield(==title)]"),
            VisualFormatConstraintOptions(string: "H:|-40-[line]-40-|"),
            VisualFormatConstraintOptions(string: "H:|-[textview]-|"),
            VisualFormatConstraintOptions(string: "H:|-buttonLeft-[button]-buttonRight-|"),
            VisualFormatConstraintOptions(string: "V:|-top-[title]-[subtitle]-[textfield]", options: .alignAllLeft),
            VisualFormatConstraintOptions(string: "V:|-top-[photo(==photoH)]"),
            VisualFormatConstraintOptions(string: "V:[line(==1)]-[textview(==200)]-200-[button(==buttonH)]-8-|")
        ]
    }
    
    static func visualFormatMetrics() -> [String: AnyObject]? {
        
        return ["top" : 30 as AnyObject, "buttonH" : 44 as AnyObject, "buttonLeft" : 100 as AnyObject, "buttonRight" : 100 as AnyObject, "photoW" : 100 as AnyObject, "photoH" : 60 as AnyObject]
    }
    
    static func layoutConstraints() -> [ConstraintOptions]? {
        
        return [
            ConstraintOptions(identifier: "titleHeight", itemIdentifier: "title", attribute: .height, relatedBy: .equal, toItemIdentifier: nil, attribute: .height, multiplier: 1, constant: 40)
        ]
    }
	
	static func shouldRecreateAllElementsAfterUpdatePosted() -> Bool {
		
		return false
	}
}
