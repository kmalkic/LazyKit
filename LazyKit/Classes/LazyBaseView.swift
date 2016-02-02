//
//  LazyBaseView.swift
//  LazyKit
//
//  Created by Kevin Malkic on 16/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

public class LazyBaseView<T: LazyViewConfigurations>: UIView {
    
    public typealias ViewConfigurations = T
    
    public private(set) var viewManager: LazyViewManager<T>!
    
    deinit {
        
        unregisterUpdateStylesNotification(self)
    }
    
    public init() {
        
        super.init(frame: .zero)
        
        setup()
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setup()
    }
    
	private func setup() {
		
		viewManager = LazyViewManager(view: self)
		
		registerUpdateStylesNotification(self)
		
		viewDidUpdate()
	}
	
	internal func didReceiveUpdateNotification() {
		
		var canUpdate = true
		
		if let ViewConfigurationsOptions = ViewConfigurations.self as? LazyViewConfigurationsOptions.Type {
			
			canUpdate = !ViewConfigurationsOptions.shouldNotRecreateAllElementsAfterUpdatePosted()
		}
		
		if canUpdate {
			
			viewManager = LazyViewManager(view: self)
			
			viewDidUpdate()
		}
	}
	
	/**
	Called after the view has been updated from the view configurations. Would be called also after kUpdateStylesNotificationKey was posted
	*/
	public func viewDidUpdate() {
		
		
	}
}
