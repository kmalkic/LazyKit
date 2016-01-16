//
//  LazyUIFactory.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

internal class LazyUIFactory {

    //MARK: Mapping base options
        
    internal class func updateView(view: UIView, baseOptions: ViewBaseOptions?) {
        
        if let viewBaseOptions = baseOptions {
            
            view.backgroundColor = viewBaseOptions.backgroundColor ?? view.backgroundColor
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tintColor = viewBaseOptions.tintColor ?? view.tintColor
        }
    }
    
    internal class func updateLabel(label: UILabel, textOptions: TextBaseOptions?) {
        
        if let textOptions = textOptions {
            
            label.textAlignment = textOptions.textAlignment ?? label.textAlignment
            label.numberOfLines = textOptions.numberOfLines ?? label.numberOfLines
            label.font = textOptions.font ?? label.font
            label.textColor = textOptions.textColor ?? label.textColor
            label.text = textOptions.text ?? label.text
            label.adjustsFontSizeToFitWidth =  textOptions.adjustsFontSizeToFitWidth ?? label.adjustsFontSizeToFitWidth
        }
    }
    
    internal class func updateButton(button: UIButton, textOptionsForType: [UIControlState: TextBaseOptions]?) {
        
        if let textOptionsForType = textOptionsForType {
            
            for (state, textOptions) in textOptionsForType {
                
                button.setTitle(textOptions.text ?? button.titleForState(state), forState: state)
                button.setTitleColor(textOptions.textColor ?? button.titleColorForState(state), forState: state)
            }
        }
    }
    
    internal class func updateImage(imageView: UIImageView, imageOptions: ImageBaseOptions?) {
        
        if let imageOptions = imageOptions {
        
            imageView.contentMode = imageOptions.contentMode ?? imageView.contentMode
            imageView.tintColor = imageOptions.tintColor ?? imageView.tintColor
            
            if let imageNamed = imageOptions.imageNamed {
                
                imageView.image = UIImage(named: imageNamed)
            }
        }
    }
    
    //MARK: Factory
    
    internal class func view(option: ViewOptions) -> UIView {
        
        let view = option.classType.init(frame: CGRectZero)
        
        updateView(view, baseOptions: option.viewBaseOptions)
        
        return view
    }
    
    internal class func label(option: LabelOptions) -> UILabel {
		
		let label = option.classType.init(frame: CGRectZero)
        
        updateView(label, baseOptions: option.viewBaseOptions)
        
        updateLabel(label, textOptions: option.textOptions)
        
		return label
	}
    
    internal class func button(option: ButtonOptions) -> UIButton {
        
        let button = option.classType.init(type: option.type)
       
        updateView(button, baseOptions: option.viewBaseOptions)
        
        if let titleLabel = button.titleLabel, textOptions = option.textOptionsForType?[.Normal] {
            
            updateLabel(titleLabel, textOptions: textOptions)
        }
        
        updateButton(button, textOptionsForType: option.textOptionsForType)
        
        return button
    }
    
    internal class func image(option: ImageOptions) -> UIImageView {
        
        let imageView = option.classType.init(frame: CGRectZero)
        
        updateView(imageView, baseOptions: option.viewBaseOptions)
        
        updateImage(imageView, imageOptions: option.imageBaseOptions)
        
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
