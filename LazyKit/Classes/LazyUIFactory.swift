//
//  LazyUIFactory.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

open class LazyUIFactory {
    
    open class func attributedString(_ textOptions: TextBaseOptions?, existingAttributes: [String: AnyObject]? = nil) -> NSAttributedString? {
        
        if let textOptions = textOptions {
            
            let paragraphStyle = NSMutableParagraphStyle()
            
            if let existingParagraphStyle = existingAttributes?[NSParagraphStyleAttributeName] as? NSParagraphStyle {
                
                paragraphStyle.alignment = existingParagraphStyle.alignment 
                paragraphStyle.paragraphSpacing = existingParagraphStyle.paragraphSpacing 
                paragraphStyle.headIndent = existingParagraphStyle.headIndent 
                paragraphStyle.lineSpacing = existingParagraphStyle.lineSpacing 
                paragraphStyle.lineBreakMode = existingParagraphStyle.lineBreakMode 
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
    
    open class func needAttributedString(_ textOptions: TextBaseOptions?) -> Bool {
        
        if let textOptions = textOptions {
            
            return textOptions.lineSpacing != nil || textOptions.headIndent != nil || textOptions.paragraphSpacing != nil || textOptions.lineBreakMode != nil
        }
        
        return false
    }
    
    //MARK: - Mapping base options
    
    open class func updateView(_ view: UIView, viewBaseOptions: ViewBaseOptions?) {
        
        if let viewBaseOptions = viewBaseOptions {
            
            view.backgroundColor = viewBaseOptions.backgroundColor ?? view.backgroundColor
            view.tintColor = viewBaseOptions.tintColor ?? view.tintColor
            view.alpha = viewBaseOptions.alpha ?? 1
            view.layer.borderWidth = viewBaseOptions.borderWidth ?? 0
            view.layer.borderColor = viewBaseOptions.borderColor?.cgColor ?? view.layer.borderColor
            view.layer.cornerRadius = viewBaseOptions.cornerRadius ?? 0
            view.layer.masksToBounds = (view.layer.cornerRadius > 0)
            view.isUserInteractionEnabled = viewBaseOptions.userInteractionEnabled ?? view.isUserInteractionEnabled
            view.isHidden = viewBaseOptions.hidden ?? view.isHidden
        }
    }
    
    open class func updateLabel(_ label: UILabel, options: LabelOptions) {
        
        updateView(label, viewBaseOptions: options.viewBaseOptions)
        
        if let textOptions = options.textOptions {
            
            if needAttributedString(textOptions) {
                
                var existingAttributes: [String: AnyObject]?
                
                if let attributedText = label.attributedText {
                    
                    existingAttributes = attributedText.attributes(at: 0, effectiveRange: nil) as [String : AnyObject]?
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
    
    open class func updateButton(_ button: UIButton, options: ButtonOptions) {
        
        updateView(button, viewBaseOptions: options.viewBaseOptions)
        
        if let textOptions = options.textOptionsForType?[.Normal], let titleLabel = button.titleLabel {
            
            if needAttributedString(textOptions) {
                
                var existingAttributes: [String: AnyObject]?
                
                if let attributedText = titleLabel.attributedText {
                    
                    existingAttributes = attributedText.attributes(at: 0, effectiveRange: nil) as [String : AnyObject]?
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
                
                button.setTitle(textOptions.text ?? button.title(for: state.toUiControlState), for: state.toUiControlState)
                button.setTitleColor(textOptions.textColor ?? button.titleColor(for: state.toUiControlState), for: state.toUiControlState)
            }
        }
        
        if let imageOptions = options.imageOptionsForType?[.Normal], let imageView = button.imageView {
            
            imageView.clipsToBounds = true
            button.contentMode = imageOptions.contentMode ?? imageView.contentMode
            imageView.contentMode = imageOptions.contentMode ?? imageView.contentMode
            imageView.tintColor = imageOptions.tintColor ?? imageView.tintColor
        }
        
        if let imageOptionsForType = options.imageOptionsForType {
            
            for (state, imageOptions) in imageOptionsForType {
                
                if let imageNamed = imageOptions.imageNamed, let _ = imageOptions.tintColor {
                    
                    button.setImage(UIImage(named: imageNamed)?.withRenderingMode(.alwaysTemplate), for: state.toUiControlState)
                    
                } else if let imageNamed = imageOptions.imageNamed {
                    
                    button.setImage(UIImage(named: imageNamed), for: state.toUiControlState)
                }
            }
        }
    }
    
    open class func updateImage(_ imageView: UIImageView, options: ImageOptions) {
        
        updateView(imageView, viewBaseOptions: options.viewBaseOptions)
        
        if let imageOptions = options.imageBaseOptions {
            
            imageView.clipsToBounds = true
            imageView.contentMode = imageOptions.contentMode ?? imageView.contentMode
            imageView.tintColor = imageOptions.tintColor ?? imageView.tintColor
            
            if let imageNamed = imageOptions.imageNamed, let _ = imageOptions.tintColor {
                
                imageView.image = UIImage(named: imageNamed)?.withRenderingMode(.alwaysTemplate)
                
            } else if let imageNamed = imageOptions.imageNamed {
                
                imageView.image = UIImage(named: imageNamed)
            }
        }
    }
    
    open class func updateTextField(_ textField: UITextField, options: TextFieldOptions) {
        
        updateView(textField, viewBaseOptions: options.viewBaseOptions)
        
        if let textOptions = options.textOptions {
            
            if needAttributedString(textOptions) {
                
                var existingAttributes: [String: AnyObject]?
                
                if let attributedText = textField.attributedText {
                    
                    existingAttributes = attributedText.attributes(at: 0, effectiveRange: nil) as [String : AnyObject]?
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
                
                existingAttributes = attributedPlaceholder.attributes(at: 0, effectiveRange: nil) as [String : AnyObject]?
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
            textField.isSecureTextEntry = textInputOptions.secureTextEntry ?? textField.isSecureTextEntry
        }
    }
    
    open class func updateTextView(_ textView: UITextView, options: TextViewOptions) {
        
        updateView(textView, viewBaseOptions: options.viewBaseOptions)
        
        if let textOptions = options.textOptions {
            
            if needAttributedString(textOptions) {
                
                var existingAttributes: [String: AnyObject]?
                
                if let attributedText = textView.attributedText {
                    
                    existingAttributes = attributedText.attributes(at: 0, effectiveRange: nil) as [String : AnyObject]?
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
            textView.isSecureTextEntry = textInputOptions.secureTextEntry ?? textView.isSecureTextEntry
        }
    }
    
    //MARK: - Factory
    
    open class func view(_ option: ViewOptions) -> UIView {
        
        let view = option.baseOptions.classType.init(frame: .zero)
        
        updateElement(view, elementOptions: option)
        
        return view
    }
    
    open class func label(_ option: LabelOptions) -> UILabel {
        
        let label = option.baseOptions.classType.init(frame: .zero)
        
        updateElement(label, elementOptions: option)
        
        return label
    }
    
    open class func button(_ option: ButtonOptions) -> UIButton {
        
        let button = option.baseOptions.classType.init(type: option.type)
        
        updateElement(button, elementOptions: option)
        
        return button
    }
    
    open class func image(_ option: ImageOptions) -> UIImageView {
        
        let imageView = option.baseOptions.classType.init(frame: .zero)
        
        updateElement(imageView, elementOptions: option)
        
        return imageView
    }
    
    open class func textField(_ option: TextFieldOptions) -> UITextField {
        
        let textField = option.baseOptions.classType.init(frame: .zero)
        
        updateElement(textField, elementOptions: option)
        
        return textField
    }
    
    open class func textView(_ option: TextViewOptions) -> UITextView {
        
        let textView = option.baseOptions.classType.init(frame: .zero)
        
        updateElement(textView, elementOptions: option)
        
        return textView
    }
    
    open class func tableView(_ option: TableViewOptions) -> UITableView {
        
        let tableView = option.baseOptions.classType.init(frame: .zero, style: option.style)
        
        updateElement(tableView, elementOptions: option)
        
        tableView.separatorStyle = option.cellSeparatorStyle
        
        return tableView
    }
    
    open class func collectionView(_ option: CollectionViewOptions) -> UICollectionView {
        
        let collectionView = option.baseOptions.classType.init(frame: .zero, collectionViewLayout: option.collectionViewLayoutType.init())
        
        updateElement(collectionView, elementOptions: option)
        
        return collectionView
    }
    
    open class func createElement<T>(_ option: T) -> UIView? {
        
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
                
            case let elementOptions as CollectionViewOptions:
                
                v = collectionView(elementOptions)
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
    
    open class func updateElement<U: UIView, T>(_ view: U, elementOptions: T) {
        
        if let elementOptions = elementOptions as? ElementOptions {
            
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
}
