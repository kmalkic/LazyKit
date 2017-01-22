//
//  LazyBaseView.swift
//  LazyKit
//
//  Created by Kevin Malkic on 16/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

///Generic subclass of UIView
open class LazyBaseView<T: LazyViewConfigurations>: UIView {
    
    public typealias ViewConfigurations = T
    
    /**
     The view manager used on this view instance.
     */
    open fileprivate(set) var viewManager: LazyViewManager<T>!
    
    deinit {
        
        unregisterUpdateStylesNotification(self)
    }
    
    /**
     Constructor
     */
    public init() {
        
        super.init(frame: .zero)
        
        setup()
    }
    
    /**
     Constructor
     */
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	fileprivate func setup() {
		
		viewManager = LazyViewManager(view: self)
		
		registerUpdateStylesNotification(self)
		
		viewDidUpdate()
	}
	
    internal func didReceiveUpdateNotification() {
        
        var canUpdate = true
        
        if let ViewConfigurationsOptions = ViewConfigurations.self as? LazyViewConfigurationsOptions.Type {
            
            canUpdate = !ViewConfigurationsOptions.shouldRecreateAllElementsAfterUpdatePosted()
        }
        
        if canUpdate {
            
            viewManager.reloadStyles()
            
        } else {
            
            viewManager = LazyViewManager(view: self)
        }
        
        viewDidUpdate()
    }
	
	/**
	Called after the view has been updated from the view configurations. Would be called also after kUpdateStylesNotificationKey was posted
	*/
	open func viewDidUpdate() {
		
		
	}
}
