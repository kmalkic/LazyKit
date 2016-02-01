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
        
        super.init(frame: CGRectZero)
        
        setup()
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
    
        viewManager = LazyViewManager(view: self)
        
        registerUpdateStylesNotification(self)
    }
    
    internal func didReceiveUpdateNotification() {
        
        //TODO
    }
}
