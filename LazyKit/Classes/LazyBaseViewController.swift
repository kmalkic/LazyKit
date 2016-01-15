//
//  LazyBaseViewController.swift
//  LazyKit
//
//  Created by Kevin Malkic on 13/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

public class LazyBaseViewController<T: LazyViewConfigurations>: UIViewController, LazyBaseViewControllerProtocol {
	
	public typealias ViewConfigurations = T
	
	private var storedElements = [String: UIView]()
	private var visualContraints = [String: [NSLayoutConstraint]]()
	private var contraints = [String: NSLayoutConstraint]()
    
	public init() {
		
		super.init(nibName: nil, bundle: nil)
	}
	
    public func element<T: UIView>(identifier: String) -> T? {
		
		return storedElements[identifier] as? T
	}
    
    public func layoutConstaints(identifier: String) -> [NSLayoutConstraint]? {
        
        return visualContraints[identifier]
    }
    
    public func layoutConstaint(identifier: String) -> NSLayoutConstraint? {
        
        return contraints[identifier]
    }
	
	public override func viewDidLoad() {
		
		super.viewDidLoad()
		
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
