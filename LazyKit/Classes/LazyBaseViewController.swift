//
//  LazyBaseViewController.swift
//  LazyKit
//
//  Created by Kevin Malkic on 13/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

public class LazyBaseViewController<T: LazyViewConfigurations>: UIViewController {
    
    public typealias ViewConfigurations = T
    
    public private(set) var viewManager: LazyViewManager<T>?
    
    public init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let _ = view as? LazyBaseView<T> {
        
            NSException(name: "Multiple use of LazyViewConfigurations", reason: "self.view cannot be also using a LazyViewConfigurations", userInfo: nil).raise()
        }
        
        viewManager = LazyViewManager(view: view)
    }
}
