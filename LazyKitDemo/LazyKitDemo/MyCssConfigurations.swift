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
                viewBaseOptions: ViewBaseOptions(backgroundColor: .lightGrayColor())),
            
            ImageOptions(identifier: "photo",
                styleId: "photo",
                styleClass: "photo"),
            
            TextFieldOptions(identifier: "textfield",
                placeholderText: "placeholder",
                styleId: "textfield",
                textInputOptions: TextInputBaseOptions(autocapitalizationType: .Sentences, autocorrectionType: .No, spellCheckingType: .No, keyboardType: .NumbersAndPunctuation, keyboardAppearance: .Dark, returnKeyType: .Done)),
            
            TextViewOptions(identifier: "textview",
                styleId: "textview",
                textInputOptions: TextInputBaseOptions(autocapitalizationType: .Sentences, autocorrectionType: .No, spellCheckingType: .No, keyboardType: .EmailAddress, keyboardAppearance: .Dark, returnKeyType: .Done)
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
            VisualFormatConstraintOptions(string: "V:|-top-[title]-[subtitle]-[textfield]", options: .AlignAllLeft),
            VisualFormatConstraintOptions(string: "V:|-top-[photo(==photoH)]"),
            VisualFormatConstraintOptions(string: "V:[line(==1)]-[textview(==200)]-200-[button(==buttonH)]-8-|")
        ]
    }
    
    static func visualFormatMetrics() -> [String: AnyObject]? {
        
        return ["top" : 30, "buttonH" : 44, "buttonLeft" : 100, "buttonRight" : 100, "photoW" : 100, "photoH" : 60]
    }
    
    static func layoutConstraints() -> [ConstraintOptions]? {
        
        return [
            ConstraintOptions(identifier: "titleHeight", itemIdentifier: "title", attribute: .Height, relatedBy: .Equal, toItemIdentifier: nil, attribute: .Height, multiplier: 1, constant: 40)
        ]
    }
	
	static func shouldNotRecreateAllElementsAfterUpdatePosted() -> Bool {
		
		return false
	}
}
