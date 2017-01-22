//
//  MyConfigurations.swift
//  LazyKitDemo
//
//  Created by Kevin Malkic on 16/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit
import LazyKit

struct MyConfigurations: LazyViewConfigurations {
    
    static func elementsOptions() -> [ElementOptions]? {
        
        return [
            LabelOptions(identifier: "title",
                classType: CustomLabel.self,
                viewBaseOptions: ViewBaseOptions(backgroundColor: .blue),
                textOptions: TextBaseOptions(text: "hello", font: .systemFont(ofSize: 20), textAlignment: .center)
            ),
            
            LabelOptions(identifier: "subtitle",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .green),
                textOptions: TextBaseOptions(text: "hey", textAlignment: .center)
            ),
            
            ButtonOptions(identifier: "button",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .red),
                textOptionsForType: [.Normal: TextBaseOptions(text: "button"), .Highlighted: TextBaseOptions(text: "highlighted")]
            ),
            
            ViewOptions(identifier: "line",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .lightGray)
            ),
            
            ImageOptions(identifier: "photo",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .lightGray),
                imageBaseOptions: ImageBaseOptions(imageNamed: "image", contentMode: .scaleAspectFill)
            ),
            
            TextFieldOptions(identifier: "textfield",
                viewBaseOptions: ViewBaseOptions(backgroundColor: UIColor.orange),
                textOptions: TextBaseOptions(font: .systemFont(ofSize: 16), textAlignment: .center),
                placeholderOptions: TextBaseOptions(text: "placeholder", font: .systemFont(ofSize: 16), textColor: .red, textAlignment: .center),
                textInputOptions: TextInputBaseOptions(autocapitalizationType: .sentences, autocorrectionType: .no, spellCheckingType: .no, keyboardType: .numbersAndPunctuation, keyboardAppearance: .dark, returnKeyType: .done, enablesReturnKeyAutomatically: true, secureTextEntry: false)
            ),
            
            TextViewOptions(identifier: "textview",
                viewBaseOptions: ViewBaseOptions(backgroundColor: UIColor.cyan),
                textOptions: TextBaseOptions(text: "TextView", font: .systemFont(ofSize: 14), textAlignment: .left),
                textInputOptions: TextInputBaseOptions(autocapitalizationType: .sentences, autocorrectionType: .no, spellCheckingType: .no, keyboardType: .emailAddress, keyboardAppearance: .dark, returnKeyType: .done, enablesReturnKeyAutomatically: true, secureTextEntry: false)
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
}
