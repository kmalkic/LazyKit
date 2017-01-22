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
        
        view.backgroundColor = .white
    }
}

class MyView: LazyBaseView <MyConfigurations> {
    
    override init() {
        
        super.init()
        
        _ = viewManager.updateElement("title", elementOptions: LabelOptions(textOptions: TextBaseOptions(text: "Bonjour")))
        
        _ = viewManager.updateElement("button", elementOptions: ButtonOptions(textOptionsForType: [.Normal: TextBaseOptions(text: "Done"), .Highlighted: TextBaseOptions(text: "Highlighted")]))
                
        _ = viewManager.changeConstantOfLayoutConstaint("titleHeight", constant: 60)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
