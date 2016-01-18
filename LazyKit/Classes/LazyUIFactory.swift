//
//  LazyUIFactory.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

internal class LazyUIFactory {
    
    internal class func attributedString(textOptions: TextBaseOptions?, existingAttributes: [String: AnyObject]? = nil) -> NSAttributedString? {
        
        if let textOptions = textOptions {
            
            let paragraphStyle = NSMutableParagraphStyle()
            
            if let existingParagraphStyle = existingAttributes?[NSParagraphStyleAttributeName] as? NSParagraphStyle {
                
                paragraphStyle.alignment = existingParagraphStyle.alignment ?? paragraphStyle.alignment
                paragraphStyle.paragraphSpacing = existingParagraphStyle.paragraphSpacing ?? paragraphStyle.paragraphSpacing
                paragraphStyle.headIndent = existingParagraphStyle.headIndent ?? paragraphStyle.headIndent
                paragraphStyle.lineSpacing = existingParagraphStyle.lineSpacing ?? paragraphStyle.lineSpacing
                paragraphStyle.lineBreakMode = existingParagraphStyle.lineBreakMode ?? paragraphStyle.lineBreakMode
            }
            
            paragraphStyle.alignment = textOptions.textAlignment ?? paragraphStyle.alignment
            paragraphStyle.paragraphSpacing = textOptions.paragraphSpacing ?? paragraphStyle.paragraphSpacing
            paragraphStyle.headIndent = textOptions.headIndent ?? paragraphStyle.headIndent
            paragraphStyle.lineSpacing = textOptions.lineSpacing ?? paragraphStyle.lineSpacing
            paragraphStyle.lineBreakMode = textOptions.lineBreakMode ?? paragraphStyle.lineBreakMode

            var attr: [String : AnyObject] = [NSParagraphStyleAttributeName: paragraphStyle]
            
            if let existingAttribute = existingAttributes?[NSFontAttributeName] as? UIFont {
                
                attr.updateValue(existingAttribute, forKey: NSFontAttributeName)
            }
            
            if let existingAttribute = existingAttributes?[NSForegroundColorAttributeName] as? UIColor {
                
                attr.updateValue(existingAttribute, forKey: NSForegroundColorAttributeName)
            }
            
            if let font = textOptions.font {
                
                attr.updateValue(font, forKey: NSFontAttributeName)
            }
            
            if let textColor = textOptions.textColor {
                
                attr.updateValue(textColor, forKey: NSForegroundColorAttributeName)
            }
            
            if let text = textOptions.text {
                
                return NSAttributedString(string: text, attributes: attr)
            }
        }
        
        return nil
    }
    
    internal class func needAttributedString(textOptions: TextBaseOptions?) -> Bool {
        
        if let textOptions = textOptions {
            
            return textOptions.lineSpacing != nil || textOptions.headIndent != nil || textOptions.paragraphSpacing != nil || textOptions.lineBreakMode != nil
        }
        
        return false
    }
    
    //MARK: Mapping base options
    
    internal class func updateView(view: UIView, viewBaseOptions: ViewBaseOptions?) {
        
        if let viewBaseOptions = viewBaseOptions {
            
            view.backgroundColor = viewBaseOptions.backgroundColor ?? view.backgroundColor
            view.tintColor = viewBaseOptions.tintColor ?? view.tintColor
        }
    }
    
    internal class func updateLabel(label: UILabel, options: LabelOptions) {
        
        updateView(label, viewBaseOptions: options.viewBaseOptions)
        
        if let textOptions = options.textOptions {
            
            if needAttributedString(textOptions) {
                
                var existingAttributes: [String: AnyObject]?
                
                if let attributedText = label.attributedText {
                    
                    existingAttributes = attributedText.attributesAtIndex(0, effectiveRange: nil)
                }
                
                label.attributedText = attributedString(textOptions, existingAttributes: existingAttributes)
                
            } else {
                
                label.textAlignment = textOptions.textAlignment ?? label.textAlignment
                label.numberOfLines = textOptions.numberOfLines ?? label.numberOfLines
                label.font = textOptions.font ?? label.font
                label.textColor = textOptions.textColor ?? label.textColor
                label.text = textOptions.text ?? label.text
                label.adjustsFontSizeToFitWidth =  textOptions.adjustsFontSizeToFitWidth ?? label.adjustsFontSizeToFitWidth
            }
        }
    }
    
    internal class func updateButton(button: UIButton, options: ButtonOptions) {
        
        updateView(button, viewBaseOptions: options.viewBaseOptions)
        
        if let textOptions = options.textOptionsForType?[.Normal], titleLabel = button.titleLabel {
            
            if needAttributedString(textOptions) {
                
                var existingAttributes: [String: AnyObject]?
                
                if let attributedText = titleLabel.attributedText {
                    
                    existingAttributes = attributedText.attributesAtIndex(0, effectiveRange: nil)
                }
                
                titleLabel.attributedText = attributedString(textOptions, existingAttributes: existingAttributes)
                
            } else {
                
                titleLabel.textAlignment = textOptions.textAlignment ?? titleLabel.textAlignment
                titleLabel.numberOfLines = textOptions.numberOfLines ?? titleLabel.numberOfLines
                titleLabel.font = textOptions.font ?? titleLabel.font
                titleLabel.textColor = textOptions.textColor ?? titleLabel.textColor
                titleLabel.text = textOptions.text ?? titleLabel.text
                titleLabel.adjustsFontSizeToFitWidth =  textOptions.adjustsFontSizeToFitWidth ?? titleLabel.adjustsFontSizeToFitWidth
            }
        }
        
        if let textOptionsForType = options.textOptionsForType {
            
            for (state, textOptions) in textOptionsForType {
                
                button.setTitle(textOptions.text ?? button.titleForState(state), forState: state)
                button.setTitleColor(textOptions.textColor ?? button.titleColorForState(state), forState: state)
            }
        }
    }
    
    internal class func updateImage(imageView: UIImageView, options: ImageOptions) {
        
        updateView(imageView, viewBaseOptions: options.viewBaseOptions)
        
        if let imageOptions = options.imageBaseOptions {
            
            imageView.clipsToBounds = true
            imageView.contentMode = imageOptions.contentMode ?? imageView.contentMode
            imageView.tintColor = imageOptions.tintColor ?? imageView.tintColor
            
            if let imageNamed = imageOptions.imageNamed {
                
                imageView.image = UIImage(named: imageNamed)
            }
        }
    }
    
    internal class func updateTextField(textField: UITextField, options: TextFieldOptions) {
        
        updateView(textField, viewBaseOptions: options.viewBaseOptions)
        
        if let textOptions = options.textOptions {
            
            if needAttributedString(textOptions) {
                
                var existingAttributes: [String: AnyObject]?
                
                if let attributedText = textField.attributedText {
                    
                    existingAttributes = attributedText.attributesAtIndex(0, effectiveRange: nil)
                }
                
                textField.attributedText = attributedString(textOptions, existingAttributes: existingAttributes)
                
            } else {
                
                textField.attributedText = nil
                textField.textAlignment = textOptions.textAlignment ?? textField.textAlignment
                textField.font = textOptions.font ?? textField.font
                textField.textColor = textOptions.textColor ?? textField.textColor
                textField.text = textOptions.text ?? textField.text
                textField.adjustsFontSizeToFitWidth =  textOptions.adjustsFontSizeToFitWidth ?? textField.adjustsFontSizeToFitWidth
            }
        }
        
        if let textOptions = options.placeholderOptions {
            
            var existingAttributes: [String: AnyObject]?
            
            if let attributedPlaceholder = textField.attributedPlaceholder {
                
                existingAttributes = attributedPlaceholder.attributesAtIndex(0, effectiveRange: nil)
            }
            
            textField.attributedPlaceholder = attributedString(textOptions, existingAttributes: existingAttributes)
        }
        
        if let textInputOptions = options.textInputOptions {
            
            textField.autocapitalizationType = textInputOptions.autocapitalizationType ?? textField.autocapitalizationType
            textField.autocorrectionType = textInputOptions.autocorrectionType ?? textField.autocorrectionType
            textField.spellCheckingType = textInputOptions.spellCheckingType ?? textField.spellCheckingType
            textField.keyboardType = textInputOptions.keyboardType ?? textField.keyboardType
            textField.keyboardAppearance = textInputOptions.keyboardAppearance ?? textField.keyboardAppearance
            textField.returnKeyType = textInputOptions.returnKeyType ?? textField.returnKeyType
            textField.enablesReturnKeyAutomatically = textInputOptions.enablesReturnKeyAutomatically ?? textField.enablesReturnKeyAutomatically
            textField.secureTextEntry = textInputOptions.secureTextEntry ?? textField.secureTextEntry
        }
    }
    
    internal class func updateTextView(textView: UITextView, options: TextViewOptions) {
        
        updateView(textView, viewBaseOptions: options.viewBaseOptions)
        
        if let textOptions = options.textOptions {
            
            if needAttributedString(textOptions) {
                
                var existingAttributes: [String: AnyObject]?
                
                if let attributedText = textView.attributedText {
                    
                    existingAttributes = attributedText.attributesAtIndex(0, effectiveRange: nil)
                }
                
                textView.attributedText = attributedString(textOptions, existingAttributes: existingAttributes)
                
            } else {
                
                textView.attributedText = nil
                textView.textAlignment = textOptions.textAlignment ?? textView.textAlignment
                textView.font = textOptions.font ?? textView.font
                textView.textColor = textOptions.textColor ?? textView.textColor
                textView.text = textOptions.text ?? textView.text
            }
        }
        
        if let textInputOptions = options.textInputOptions {
            
            textView.autocapitalizationType = textInputOptions.autocapitalizationType ?? textView.autocapitalizationType
            textView.autocorrectionType = textInputOptions.autocorrectionType ?? textView.autocorrectionType
            textView.spellCheckingType = textInputOptions.spellCheckingType ?? textView.spellCheckingType
            textView.keyboardType = textInputOptions.keyboardType ?? textView.keyboardType
            textView.keyboardAppearance = textInputOptions.keyboardAppearance ?? textView.keyboardAppearance
            textView.returnKeyType = textInputOptions.returnKeyType ?? textView.returnKeyType
            textView.enablesReturnKeyAutomatically = textInputOptions.enablesReturnKeyAutomatically ?? textView.enablesReturnKeyAutomatically
            textView.secureTextEntry = textInputOptions.secureTextEntry ?? textView.secureTextEntry
        }
    }
    
    //MARK: Factory
    
    internal class func view(option: ViewOptions) -> UIView {
        
        let view = option.classType.init(frame: .zero)
        
        updateElement(view, elementOptions: option)
        
        return view
    }
    
    internal class func label(option: LabelOptions) -> UILabel {
        
        let label = option.classType.init(frame: .zero)
        
        updateElement(label, elementOptions: option)
        
        return label
    }
    
    internal class func button(option: ButtonOptions) -> UIButton {
        
        let button = option.classType.init(type: option.type)
        
        updateElement(button, elementOptions: option)
        
        return button
    }
    
    internal class func image(option: ImageOptions) -> UIImageView {
        
        let imageView = option.classType.init(frame: .zero)
        
        updateElement(imageView, elementOptions: option)
        
        return imageView
    }
    
    internal class func textField(option: TextFieldOptions) -> UITextField {
        
        let textField = option.classType.init(frame: .zero)
        
        updateElement(textField, elementOptions: option)
        
        return textField
    }
    
    internal class func textView(option: TextViewOptions) -> UITextView {
        
        let textView = option.classType.init(frame: .zero)
        
        updateElement(textView, elementOptions: option)
        
        return textView
    }
    
    internal class func tableView(option: TableViewOptions) -> UITableView {
        
        let tableView = option.classType.init(frame: .zero, style: option.style)
        
        updateElement(tableView, elementOptions: option)
        
        return tableView
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
                
            case let elementOptions as TextFieldOptions:
                
                v = textField(elementOptions)
                break
                
            case let elementOptions as TextViewOptions:
                
                v = textView(elementOptions)
                break
                
            case let elementOptions as TableViewOptions:
                
                v = tableView(elementOptions)
                break
                
            default:
                break
            }
            
            if let v = v {
                
                v.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
        return v
    }
    
    internal class func updateElement<U: UIView, T: ElementOptions>(view: U, elementOptions: T) {

        updateView(view, viewBaseOptions: elementOptions.viewBaseOptions)
        
        switch elementOptions {
            
        case let elementOptions as LabelOptions where view is UILabel:
            
            updateLabel(view as! UILabel, options: elementOptions)
            break
            
        case let elementOptions as ButtonOptions where view is UIButton:
            
            updateButton(view as! UIButton, options: elementOptions)
            break

        case let elementOptions as ImageOptions where view is UIImageView:
            
            updateImage(view as! UIImageView, options: elementOptions)
            break
            
        case let elementOptions as TextFieldOptions where view is UITextField:
            
            let textField = view as! UITextField
            
            textField.borderStyle = elementOptions.borderStyle ?? textField.borderStyle
            
            updateTextField(textField, options: elementOptions)
            break
            
        case let elementOptions as TextViewOptions where view is UITextView:
            
            updateTextView(view as! UITextView, options: elementOptions)
            break
            
        default:
            break
        }
        
        if let accessibilityIdentifier = elementOptions.viewBaseOptions?.accessibilityIdentifier {
            
            view.accessibilityIdentifier = accessibilityIdentifier
            view.isAccessibilityElement = true
        }
    }
}
