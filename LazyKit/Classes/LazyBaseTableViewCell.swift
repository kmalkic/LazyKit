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
    
    public private(set) var viewManager: LazyViewManager<T>!
    
     override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        viewManager = LazyViewManager(view: contentView)
    }
}
