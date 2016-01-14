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
		
		let label = UILabel(frame: CGRectZero)
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
        
        let button = UIButton(type: option.type)
        button.backgroundColor = option.viewOptions.backgroundColor
        
        if let titleLabel = button.titleLabel, normalTextOptions = option.normalTextOptions {
            
            titleLabel.textAlignment = normalTextOptions.textAlignment
            titleLabel.numberOfLines = normalTextOptions.numberOfLines
            titleLabel.font = normalTextOptions.font
            titleLabel.adjustsFontSizeToFitWidth =  normalTextOptions.adjustsFontSizeToFitWidth
        }
        
        button.setTitle(option.normalTextOptions?.text, forState: .Normal)
        button.setTitleColor(option.normalTextOptions?.textColor, forState: .Normal)

        button.setTitle(option.highlightTextOptions?.text, forState: .Highlighted)
        button.setTitleColor(option.highlightTextOptions?.textColor, forState: .Highlighted)
        
        button.setTitle(option.selectedTextOptions?.text, forState: .Selected)
        button.setTitleColor(option.selectedTextOptions?.textColor, forState: .Selected)
        
        button.setTitle(option.disabledTextOptions?.text, forState: .Disabled)
        button.setTitleColor(option.disabledTextOptions?.textColor, forState: .Disabled)
        
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
