//
//  MyViewController.swift
//  LazyKitDemo
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit
import LazyKit

class CustomLabel: UILabel {
    
    
}

class MyViewControllerTest1: LazyBaseViewController <MyConfigurations> {
    
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		view.backgroundColor = .whiteColor()

        viewManager.updateElement("title", elementOptions: LabelOptions(textOptions: TextBaseOptions(text: "Bonjour")))
        
        viewManager.updateElement("button", elementOptions: ButtonOptions(textOptionsForType: [.Normal: TextBaseOptions(text: "Done"), .Highlighted: TextBaseOptions(text: "Highlighted")]))
        
        viewManager.changeConstantOfLayoutConstaint("titleHeight", constant: 60)
        
        viewManager.updateElement("textfield", elementOptions: TextFieldOptions(textOptions: TextBaseOptions(text: "Done", textColor: .greenColor()), placeholderOptions: TextBaseOptions(text: "new placeholder")))
    }
}