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
    
    /**
     The UIView presenting the configurations, or nil if the view is deallocated.
     */
    public weak private(set) var view: UIView?
	
	deinit {
		
		for (_, subview) in storedElements {
			
			subview.removeFromSuperview()
		}
		
		if let view = view {

			for (_, contraints) in visualContraints {
			
				view.removeConstraints(contraints)
			}
			
			for (_, contraint) in contraints {
				
				view.removeConstraint(contraint)
			}
		}
	}
	
    /**
     Constructor
     
     - param view: the view that present the configurations.
     */
    public init(view: UIView) {
        
        self.view = view
        initialize()
    }
    
    private func initialize() {
        
        if let view = view {
            
            if let elementsOptions = ViewConfigurations.elementsOptions() {
                
                for elementOptions in elementsOptions {
                    
                    if let element = LazyUIFactory.createElement(elementOptions) {
						
						elementOptions.getStyleIdentifiers({ (styleId, styleClass) -> Void in
							
							if let styleSet = LazyStyleSheetManager.shared.stylingForView(element, styleId: styleId, styleClass: styleClass) {
								
								if let newElementOptions = self.convertStyleSetToBaseOptions(elementOptions, styleSet: styleSet) {
									
									LazyUIFactory.updateElement(element, elementOptions: newElementOptions)
								}
							}
						})
						
						elementOptions.getStyleIdentifier({ (identifier) -> Void in
							
							self.storedElements[identifier] = element
						})
						
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
                    
                    var item2 = item1.superview
                    
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
	
    internal func convertStyleSetToBaseOptions(options: ElementOptions, styleSet: LazyStyleSet) -> ElementOptions? {
    
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
        
        if let decorationSet = styleSet.decorationSet {
            
            if viewBaseOptions == nil {
            
                viewBaseOptions = ViewBaseOptions()
            }
            
            viewBaseOptions!.borderColor = decorationSet.borders?.top?.color?.color()
            viewBaseOptions!.borderWidth = decorationSet.borders?.top?.value
            viewBaseOptions!.cornerRadius = decorationSet.borders?.cornerRadiusTopLeft?.value
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
            
            var textOptionsForType: [LazyControlState: TextBaseOptions]?
            
            if textBaseOptions != nil {
            
                textOptionsForType = [LazyControlState: TextBaseOptions]()
                
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
	
	//MARK: - Public
	
	/**
	Reload all current views to initial setup
	*/
	public func updateStyles() {
		
		if let elementsOptions = ViewConfigurations.elementsOptions() {
			
			for elementOptions in elementsOptions {
				
				elementOptions.getStyleIdentifier({ (identifier) -> Void in
					
					guard let element = self.element(identifier) else {
						
						return
					}
					
					LazyUIFactory.updateElement(element, elementOptions: elementOptions)
					
					elementOptions.getStyleIdentifiers({ (styleId, styleClass) -> Void in
						
						if let styleSet = LazyStyleSheetManager.shared.stylingForView(element, styleId: styleId, styleClass: styleClass) {
							
							if let newElementOptions = self.convertStyleSetToBaseOptions(elementOptions, styleSet: styleSet) {
								
								LazyUIFactory.updateElement(element, elementOptions: newElementOptions)
							}
						}
					})
				})
			}
		}
	}
	
    //MARK: - Getters
	
    /**
    Get an UI element for a given identifier.
	
    - parameter identifier: identifier of the element.
    - returns: The element if founded.
    */
    public func element<T: UIView>(identifier: String) -> T? {
		
        return storedElements[identifier] as? T
    }
	
    /**
     Get an UILabel for a given identifier.
	
     - parameter identifier: identifier of the label.
     - returns: The label if founded.
     */
    public func label<T: UILabel>(identifier: String) -> T? {
        
        return element(identifier) as? T
    }
    
    /**
     Get an UIButton for a given identifier.
     
     - parameter identifier: identifier of the button.
     - returns: The button if founded.
     */
    public func button<T: UIButton>(identifier: String) -> T? {
        
        return element(identifier) as? T
    }
    
    /**
     Get an UIImageView for a given identifier.
     
     - parameter identifier: identifier of the imageView.
     - returns: The imageView if founded.
     */
    public func imageView<T: UIImageView>(identifier: String) -> T? {
        
        return element(identifier) as? T
    }
    
    /**
     Get an UITableView for a given identifier.
     
     - parameter identifier: identifier of the tableView.
     - returns: The tableView if founded.
     */
    public func tableView<T: UITableView>(identifier: String) -> T? {
        
        return element(identifier) as? T
    }
    
    /**
     Get an UITextField for a given identifier.
     
     - parameter identifier: identifier of the textField.
     - returns: The textField if founded.
     */
    public func textField<T: UITextField>(identifier: String) -> T? {
        
        return element(identifier) as? T
    }
    
    /**
     Get an UITextView for a given identifier.
     
     - parameter identifier: identifier of the textView.
     - returns: The textView if founded.
     */
    public func textView<T: UITextView>(identifier: String) -> T? {
        
        return element(identifier) as? T
    }
    
    //MARK: - Updates
    
    /**
    Updates an UI element with any ElementOptions, if suited for the type of the element found with the given identifier.
    
    - parameter identifier: identifier of the element given.
    - parameter elementOptions: Some options to be applied.
    - returns: If element was founded.
    */
    public func updateElement<T: ElementOptions>(identifier: String, elementOptions: T) -> Bool {
        
        guard let element = storedElements[identifier] else {
            
            return false
        }

        LazyUIFactory.updateElement(element, elementOptions: elementOptions)
                
        return true
    }
    
    /**
     Updates an UI element with closure, if element found with the given identifier.
     
     - parameter identifier: identifier of the element given.
     - parameter type: The type of the element you looking for.
     */
    public func updateElement<T>(identifier: String, type: T.Type, block: (element: T) -> Void) {
        
        if let element = element(identifier) {

            if element is T {
                
                block(element: element as! T)
				
			} else {
			
				print("element for identifier: " + identifier + " is not of type: \(T.self)")
			}
		
		} else {
		
			print("no such element for identifier: " + identifier)
		}
    }
    
    /**
     The constraints created with visual format constraints.
     
     - parameter identifier: identifier of the given set of constraints.
     - returns: The constraints if any.
     */
    public func layoutConstraints(identifier: String) -> [NSLayoutConstraint]? {
        
        return visualContraints[identifier]
    }
    
    /**
     The constraints created with single layout constraint.
     
     - parameter identifier: identifier of the given constraint.
     - returns: The constraint if any.
     */
    public func layoutConstraint(identifier: String) -> NSLayoutConstraint? {
        
        return contraints[identifier]
    }
    
    /**
     The constraints created with single layout constraint.
     
     - parameter identifier: identifier of the given constraint. (Won't work with constraints created using visual format constraints!)
     - returns: If constraint was founded.
     */
    public func changeConstantOfLayoutConstaint(identifier: String, constant: CGFloat) -> Bool {
        
        guard let layoutConstraint = contraints[identifier] else {
            
            return false
        }
        
        layoutConstraint.constant = constant
        
        return true
    }
}
