//
//  LazyViewManager.swift
//  LazyKit
//
//  Created by Kevin Malkic on 16/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

public class LazyViewManager<T: LazyViewConfigurations> {

    private typealias ViewConfigurations = T
    
    private var storedElements = [String: UIView]()
    private var visualContraints = [String: [NSLayoutConstraint]]()
    private var contraints = [String: NSLayoutConstraint]()
    
    public weak private(set) var view: UIView?
    
    public init(view: UIView) {
        
        self.view = view
        initialize()
    }
    
    private func initialize() {
        
        if let view = view {
            
            if let elementsOptions = ViewConfigurations.elementsOptions() {
                
                for elementOptions in elementsOptions {
                    
                    if let element = LazyUIFactory.element(elementOptions) {
                        
                        if elementOptions.styleClass != nil || elementOptions.styleId != nil {
                            
                            if let styleSet = LazyStyleSheetManager.shared.stylingForView(element, styleId: elementOptions.styleId, styleClass: elementOptions.styleClass) {
                                
                                if let newElementOptions = convertStyleSetToBaseOptions(elementOptions, styleSet: styleSet) {
                                
                                    LazyUIFactory.updateElement(element, elementOptions: newElementOptions)
                                }
                            }
                        }
                        
                        if let identifier = elementOptions.identifier {

                            storedElements[identifier] = element
                        }
                        
                        view.addSubview(element)
                    }
                }
            }
            
            if let visualFormatConstraintOptions = ViewConfigurations.visualFormatConstraintOptions() {
                
                let metrics = ViewConfigurations.visualFormatMetrics()
                
                for visualFormatConstraintOption in visualFormatConstraintOptions {
                    
                    let constraints = NSLayoutConstraint.constraintsWithVisualFormat(visualFormatConstraintOption.string, options: visualFormatConstraintOption.options, metrics: metrics, views: storedElements)
                    
                    if let identifier = visualFormatConstraintOption.identifier {
                        
                        visualContraints[identifier] = constraints
                    }
                    
                    view.addConstraints(constraints)
                }
            }
            
            if let layoutConstraints = ViewConfigurations.layoutConstraints() {
                
                for layoutConstraint in layoutConstraints {
                    
                    guard let item1: UIView = element(layoutConstraint.identifier1) else {
                        
                        continue
                    }
                    
                    var item2: UIView?
                    
                    if let identifier2 = layoutConstraint.identifier2 {
                        
                        item2 = element(identifier2)
                    }
                    
                    let constraint = NSLayoutConstraint(item: item1, attribute: layoutConstraint.attribute1, relatedBy: layoutConstraint.relatedBy, toItem: item2, attribute: layoutConstraint.attribute2, multiplier: layoutConstraint.multiplier, constant: layoutConstraint.constant)
                    
                    if let identifier = layoutConstraint.identifier {
                        
                        contraints[identifier] = constraint
                    }
                    
                    view.addConstraint(constraint)
                }
            }
        }
    }
    
    private func convertStyleSetToBaseOptions(options: ElementOptions, styleSet: LazyStyleSet) -> ElementOptions? {
    
        var textBaseOptions: TextBaseOptions?
        var placeholderBaseOptions: TextBaseOptions?
        var viewBaseOptions: ViewBaseOptions?
        var imageBaseOptions: ImageBaseOptions?
        
        if let basicSet = styleSet.basicSet {
            
            viewBaseOptions = ViewBaseOptions(backgroundColor: basicSet.backgroundColor?.color(), tintColor: basicSet.tintColor?.color())
            
            if let image = basicSet.image {
            
                imageBaseOptions = ImageBaseOptions(imageNamed: image.imageName, contentMode: image.contentMode, tintColor: image.tintColor?.color())
            }
        }
        
        if let textSet = styleSet.textSet {
            
            textBaseOptions = TextBaseOptions(font: textSet.fontObj?.font(), textColor: textSet.textColor?.color(), textAlignment: textSet.textAlignment?.alignment, numberOfLines: textSet.numberOfLines, adjustsFontSizeToFitWidth: false, lineSpacing: textSet.paragraph?.lineSpacing?.value, paragraphSpacing: textSet.paragraph?.paragraphSpacing?.value, headIndent: textSet.paragraph?.headIndent?.value, lineBreakMode: textSet.paragraph?.lineBreakMode)
        }
        
        if let textSet = styleSet.placeholderSet {
            
            placeholderBaseOptions = TextBaseOptions(font: textSet.fontObj?.font(), textColor: textSet.textColor?.color(), textAlignment: textSet.textAlignment?.alignment, numberOfLines: textSet.numberOfLines, adjustsFontSizeToFitWidth: false, lineSpacing: textSet.paragraph?.lineSpacing?.value, paragraphSpacing: textSet.paragraph?.paragraphSpacing?.value, headIndent: textSet.paragraph?.headIndent?.value, lineBreakMode: textSet.paragraph?.lineBreakMode)
        }
        
        switch options {
            
        case var elementOptions as LabelOptions:
            
            elementOptions.viewBaseOptions = elementOptions.viewBaseOptions + viewBaseOptions
            elementOptions.textOptions = elementOptions.textOptions + textBaseOptions
            
            return elementOptions
            
        case var elementOptions as ButtonOptions:
            
            var textOptionsForType: [UIControlState: TextBaseOptions]?
            
            if textBaseOptions != nil {
            
                textOptionsForType = [UIControlState: TextBaseOptions]()
                
                textOptionsForType![.Normal] = textBaseOptions!
            }
            
            elementOptions.viewBaseOptions = elementOptions.viewBaseOptions + viewBaseOptions
            elementOptions.textOptionsForType = elementOptions.textOptionsForType + textOptionsForType
            
            return elementOptions
            
        case var elementOptions as TextFieldOptions:
            
            elementOptions.viewBaseOptions = elementOptions.viewBaseOptions + viewBaseOptions
            elementOptions.textOptions = elementOptions.textOptions + textBaseOptions
            elementOptions.placeholderOptions = elementOptions.placeholderOptions + placeholderBaseOptions
            
            return elementOptions
            
        case var elementOptions as TextViewOptions:
            
            elementOptions.viewBaseOptions = elementOptions.viewBaseOptions + viewBaseOptions
            elementOptions.textOptions = elementOptions.textOptions + textBaseOptions
            
            return elementOptions
            
        case var elementOptions as ImageOptions:
        
            elementOptions.viewBaseOptions = elementOptions.viewBaseOptions + viewBaseOptions
            elementOptions.imageBaseOptions = elementOptions.imageBaseOptions + imageBaseOptions
            
            return elementOptions
            
        case var elementOptions as TableViewOptions:
            
            elementOptions.viewBaseOptions = elementOptions.viewBaseOptions + viewBaseOptions
            
            return elementOptions
            
        case var elementOptions as ViewOptions:
            
            elementOptions.viewBaseOptions = elementOptions.viewBaseOptions + viewBaseOptions
            
            return elementOptions
            
        default:
            break
        }

        return nil
    }
    
    //MARK: Getters
    
    public func element<T: UIView>(identifier: String) -> T? {
        
        return storedElements[identifier] as? T
    }
    
    public func label<T: UILabel>(identifier: String) -> T? {
        
        return element(identifier) as? T
    }
    
    public func button<T: UIButton>(identifier: String) -> T? {
        
        return element(identifier) as? T
    }
    
    public func imageView<T: UIImageView>(identifier: String) -> T? {
        
        return element(identifier) as? T
    }
    
    public func tableView<T: UITableView>(identifier: String) -> T? {
        
        return element(identifier) as? T
    }
    
    public func textField<T: UITextField>(identifier: String) -> T? {
        
        return element(identifier) as? T
    }
    
    public func textView<T: UITextView>(identifier: String) -> T? {
        
        return element(identifier) as? T
    }
    
    //MARK: Updates
        
    public func updateElement<T: ElementOptions>(identifier: String, elementOptions: T) -> Bool {
        
        guard let element = storedElements[identifier] else {
            
            return false
        }
        
        LazyUIFactory.updateElement(element, elementOptions: elementOptions)
        
        return true
    }
    
    public func layoutConstraints(identifier: String) -> [NSLayoutConstraint]? {
        
        return visualContraints[identifier]
    }
    
    public func layoutConstraint(identifier: String) -> NSLayoutConstraint? {
        
        return contraints[identifier]
    }
    
    public func changeConstantOfLayoutConstaint(identifier: String, constant: CGFloat) -> Bool {
        
        guard let layoutConstraint = contraints[identifier] else {
            
            return false
        }
        
        layoutConstraint.constant = constant
        
        return true
    }
}

