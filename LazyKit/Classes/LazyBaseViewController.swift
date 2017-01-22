//
//  LazyBaseViewController.swift
//  LazyKit
//
//  Created by Kevin Malkic on 13/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

///Generic subclass of UIViewController
open class LazyBaseViewController<T: LazyViewConfigurations>: UIViewController {
    
    public typealias ViewConfigurations = T
    
    /**
     The view manager used on this view controller instance.
     */
    open fileprivate(set) var viewManager: LazyViewManager<T>!
    
    deinit {
        
        unregisterUpdateStylesNotification(self)
    }
    
    /**
     Constructor
     */
    public init() {
        
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let _ = view as? LazyBaseView<T> {
        
            NSException(name: NSExceptionName(rawValue: "Multiple use of LazyViewConfigurations"), reason: "self.view cannot be also using a LazyViewConfigurations", userInfo: nil).raise()
        }
        
        setup()
    }
    
	fileprivate func setup() {
		
		viewManager = LazyViewManager(view: view)
		
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
        
            viewManager = LazyViewManager(view: view)
        }
        
        viewDidUpdate()
	}
	
	/**
	Called after the view has been updated from the view configurations. Would be called also after kUpdateStylesNotificationKey was posted
	*/
	open func viewDidUpdate() {
		
		
	}
}
