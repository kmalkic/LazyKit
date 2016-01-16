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
                    
                    if let identifier = elementOptions.identifier {
                        
                        if let view = LazyUIFactory.element(elementOptions) {
                            
                            storedElements[identifier] = view
                        }
                    }
                }
            }
            
            for (_, element) in storedElements {
                
                view.addSubview(element)
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
    
    public func element<T: UIView>(identifier: String) -> T? {
        
        return storedElements[identifier] as? T
    }
    
    public func updateElementForStates(identifier: String, baseOptions: [UIControlState: BaseOptions]) -> Bool {
        
        guard let element = storedElements[identifier] else {
            
            return false
        }
        
        guard let button = element as? UIButton else {
            
            return false
        }
        
        guard let textOptionsForType = baseOptions as? [UIControlState: TextBaseOptions] else {
            
            return false
        }
        
        LazyUIFactory.updateButton(button, textOptionsForType: textOptionsForType)
        
        return true
    }
    
    public func updateElement<T: BaseOptions>(identifier: String, baseOptions: T) -> Bool {
        
        guard let element = storedElements[identifier] else {
            
            return false
        }
        
        switch baseOptions {
            
        case let baseOptions as ViewBaseOptions:
            
            LazyUIFactory.updateView(element, baseOptions: baseOptions)
            
            break
            
        case let baseOptions as TextBaseOptions:
            
            guard let label = element as? UILabel else {
                
                return false
            }
            
            LazyUIFactory.updateLabel(label, textOptions: baseOptions)
            
            break
            
        case let baseOptions as [UIControlState: TextBaseOptions]:
            
            guard let button = element as? UIButton else {
                
                return false
            }
            
            LazyUIFactory.updateButton(button, textOptionsForType: baseOptions)
            
            break
            
        case let baseOptions as ImageBaseOptions:
            
            guard let imageView = element as? UIImageView else {
                
                return false
            }
            
            LazyUIFactory.updateImage(imageView, imageOptions: baseOptions)
            
            break
            
        default:
            
            return false
        }
        
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

