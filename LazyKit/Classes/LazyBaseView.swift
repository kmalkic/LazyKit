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
    
    public init() {
        
        super.init(frame: CGRectZero)
        
        viewManager = LazyViewManager(view: self)
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        viewManager = LazyViewManager(view: self)
    }
}
