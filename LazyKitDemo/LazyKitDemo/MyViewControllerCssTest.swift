//
//  MyViewControllerTest3.swift
//  LazyKitDemo
//
//  Created by Kevin Malkic on 18/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit
import LazyKit

class MyViewControllerCssTest: LazyBaseViewController <MyCssConfigurations> {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .whiteColor()
        
        viewManager.updateElement("title", type: UILabel.self) { (element) -> Void in
            
            element.text = "Some title"
        }
    }
}
