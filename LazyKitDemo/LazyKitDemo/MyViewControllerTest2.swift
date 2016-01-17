//
//  MyViewControllerTest2.swift
//  LazyKitDemo
//
//  Created by Kevin Malkic on 16/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit
import LazyKit

class MyViewControllerTest2: UIViewController {
    
    override func loadView() {
        
        view = MyView()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .whiteColor()
    }
}

class MyView: LazyBaseView <MyConfigurations> {
    
    override init() {
        
        super.init()
        
        viewManager.updateElement("title", baseOptions: TextBaseOptions(text: "Bonjour"))
        
        viewManager.updateElementForStates("button", baseOptions: [.Normal: TextBaseOptions(text: "Done"), .Highlighted: TextBaseOptions(text: "Highlighted")])
        
        viewManager.changeConstantOfLayoutConstaint("titleHeight", constant: 60)
    }
}
