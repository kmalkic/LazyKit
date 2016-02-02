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

		
		//Example of ways to update an element:
		
        viewManager.updateElement("title", elementOptions: LabelOptions(textOptions: TextBaseOptions(text: "Bonjour")))
		
		viewManager.updateElement("title", type: UILabel.self) { (element) -> Void in
			
			element.text = "Bonjour"
		}
		
		if let title: UILabel = viewManager.element("title") {
			
			title.text = "Bonjour"
		}
		
		if let title = viewManager.label("title") {
			
			title.text = "Bonjour"
		}
		
		viewManager.label("title")!.text = "Bonjour"
		
		
		
		//Others
        viewManager.updateElement("button", elementOptions: ButtonOptions(textOptionsForType: [.Normal: TextBaseOptions(text: "Done"), .Highlighted: TextBaseOptions(text: "Highlighted")]))
        
        viewManager.changeConstantOfLayoutConstaint("titleHeight", constant: 60)
        
        viewManager.updateElement("textfield", elementOptions: TextFieldOptions(textOptions: TextBaseOptions(text: "Done", textColor: .greenColor()), placeholderOptions: TextBaseOptions(text: "new placeholder")))
    }
}