//
//  LazyUIFactory.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

internal class LazyUIFactory {

    internal class func label(option: LabelOptions) -> UILabel {
		
		let label = option.classType.init(frame: CGRectZero)
        label.backgroundColor = option.viewOptions.backgroundColor
		label.textAlignment = option.textOptions.textAlignment
		label.numberOfLines = option.textOptions.numberOfLines
		label.font = option.textOptions.font
		label.textColor = option.textOptions.textColor
		label.text = option.textOptions.text
		label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth =  option.textOptions.adjustsFontSizeToFitWidth
        
		return label
	}
    
    internal class func button(option: ButtonOptions) -> UIButton {
        
        let button = option.classType.init(type: option.type)
        button.backgroundColor = option.viewOptions.backgroundColor
        
        if let titleLabel = button.titleLabel, textOptions = option.textOptionsForType?[.Normal] {
            
            titleLabel.textAlignment = textOptions.textAlignment
            titleLabel.numberOfLines = textOptions.numberOfLines
            titleLabel.font = textOptions.font
            titleLabel.adjustsFontSizeToFitWidth =  textOptions.adjustsFontSizeToFitWidth
        }
        
        if let textOptionsForType = option.textOptionsForType {
            
            for (state, textOptions) in textOptionsForType {
                
                button.setTitle(textOptions.text, forState: state)
                button.setTitleColor(textOptions.textColor, forState: state)
            }
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
	
    internal class func element<T>(option: T) -> UIView? {
        
        var view: UIView?
        
        if let elementOptions = option as? ElementOptions {
            
            switch elementOptions {
            
            case let elementOptions as LabelOptions:
                
                view = label(elementOptions)
                break
               
            case let elementOptions as ButtonOptions:
                
                view = button(elementOptions)
                break
                
            default:
                break
            }
            
            if let elementOptions = elementOptions as? LabelOptions {
            
                view = label(elementOptions)
                
            } else if let elementOptions = elementOptions as? LabelOptions {
                
                view = label(elementOptions)
            }
            
            if let accessibilityIdentifier = elementOptions.viewOptions.accessibilityIdentifier, view = view {
            
                view.accessibilityIdentifier = accessibilityIdentifier
                view.isAccessibilityElement = true
            }
        }
        
        return view
    }
}
