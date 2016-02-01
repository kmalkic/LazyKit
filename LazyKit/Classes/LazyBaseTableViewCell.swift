//
//  LazyBaseTableViewCell.swift
//  LazyKit
//
//  Created by Kevin Malkic on 17/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

public class LazyBaseTableViewCell<T: LazyViewConfigurations>: UITableViewCell {

    public typealias ViewConfigurations = T
    
    deinit {
        
        unregisterUpdateStylesNotification(self)
    }
    
    public private(set) var viewManager: LazyViewManager<T>!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    private func setup() {
        
        viewManager = LazyViewManager(view: contentView)
        
        registerUpdateStylesNotification(self)
    }
    
    internal func didReceiveUpdateNotification() {
        
        //TODO
    }
}
