//
//  LazyBaseTableViewCell.swift
//  LazyKit
//
//  Created by Kevin Malkic on 17/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

///Generic subclass of UITableViewCell
public class LazyBaseTableViewCell<T: LazyViewConfigurations>: UITableViewCell {

    public typealias ViewConfigurations = T
    
    deinit {
        
        unregisterUpdateStylesNotification(self)
    }
    
    /**
     The view manager used on this table view cell instance.
     */
    public private(set) var viewManager: LazyViewManager<T>!
    
    /**
     Constructor
     */
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    private func setup() {
        
        viewManager = LazyViewManager(view: contentView)

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
            
            viewManager = LazyViewManager(view: contentView)
        }
        
        viewDidUpdate()
    }

	/**
	Called after the view has been updated from the view configurations. Would be called also after kUpdateStylesNotificationKey was posted
	*/
	public func viewDidUpdate() {
	
		
	}
}
