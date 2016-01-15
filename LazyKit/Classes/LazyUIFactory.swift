//
//  LazyUIFactory.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

internal class LazyUIFactory {

    internal class func styleView(view: UIView, viewBaseOptions: ViewBaseOptions?) {
        
        if let viewBaseOptions = viewBaseOptions {
            
            view.backgroundColor = viewBaseOptions.backgroundColor
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = viewBaseOptions.contentMode
            
            if let tintColor = viewBaseOptions.tintColor {
                
                view.tintColor = tintColor
            }
        }
    }
    
    internal class func view(option: ViewOptions) -> UIView {
        
        let view = option.classType.init(frame: CGRectZero)
        
        styleView(view, viewBaseOptions: option.viewBaseOptions)
        
        return view
    }
    
    internal class func label(option: LabelOptions) -> UILabel {
		
		let label = option.classType.init(frame: CGRectZero)
        
        styleView(label, viewBaseOptions: option.viewBaseOptions)
        
        if let textOptions = option.textOptions {
            
            label.textAlignment = textOptions.textAlignment
            label.numberOfLines = textOptions.numberOfLines
            label.font = textOptions.font
            label.textColor = textOptions.textColor
            label.text = textOptions.text
            
            label.adjustsFontSizeToFitWidth =  textOptions.adjustsFontSizeToFitWidth
        }
		return label
	}
    
    internal class func button(option: ButtonOptions) -> UIButton {
        
        let button = option.classType.init(type: option.type)
       
        styleView(button, viewBaseOptions: option.viewBaseOptions)
        
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
    
    internal class func image(option: ImageOptions) -> UIImageView {
        
        let imageView = option.classType.init(frame: CGRectZero)
        
        styleView(imageView, viewBaseOptions: option.viewBaseOptions)
        
        if let imageNamed = option.imageNamed {
            
            imageView.image = UIImage(named: imageNamed)
        }
        
        return imageView
    }
	
    internal class func element<T>(option: T) -> UIView? {
        
        var v: UIView?
        
        if let elementOptions = option as? ElementOptions {
            
            switch elementOptions {
            
            case let elementOptions as LabelOptions:
                
                v = label(elementOptions)
                break
               
            case let elementOptions as ButtonOptions:
                
                v = button(elementOptions)
                break
                
            case let elementOptions as ViewOptions:
                
                v = view(elementOptions)
                break
                
            case let elementOptions as ImageOptions:
                
                v = image(elementOptions)
                break
                
            default:
                break
            }
            
            if let accessibilityIdentifier = elementOptions.viewBaseOptions?.accessibilityIdentifier, v = v {
            
                v.accessibilityIdentifier = accessibilityIdentifier
                v.isAccessibilityElement = true
            }
            
            if let tintColor = elementOptions.viewBaseOptions?.tintColor, v = v {
            
                v.tintColor = tintColor
            }
        }
        
        return v
    }
}
