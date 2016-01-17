//
//  LazyBaseCollectionViewCell.swift
//  LazyKit
//
//  Created by Kevin Malkic on 17/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

public class LazyBaseCollectionViewCell<T: LazyViewConfigurations>: UICollectionViewCell {
    
    public typealias ViewConfigurations = T
    
    public private(set) var viewManager: LazyViewManager<T>!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        viewManager = LazyViewManager(view: contentView)
    }
}
