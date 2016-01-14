//
//  MyViewController.swift
//  LazyKitDemo
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit
import LazyKit

class MyConf: LazyViewConfigurations {

	static func elementsOptions() -> [ElementOptions]? {
	
		return [
			LabelOptions(viewOptions: ViewBaseOptions(identifier: "title", backgroundColor: .blueColor()), textOptions: TextBaseOptions(text: "hello", textAlignment: .Center)),
			LabelOptions(viewOptions: ViewBaseOptions(identifier: "subtitle", backgroundColor: .greenColor()), textOptions: TextBaseOptions(text: "hello", textAlignment: .Center)),
            ButtonOptions(viewOptions: ViewBaseOptions(identifier: "button", backgroundColor: .redColor()), normalTextOptions: TextBaseOptions(text: "button", textAlignment: .Center))
		]
	}
	
	static func visualFormatConstraintOptions() -> [VisualFormatConstraintOptions]? {
	
		return [
			VisualFormatConstraintOptions(string: "H:|[title]|"),
			VisualFormatConstraintOptions(string: "H:|[subtitle]|"),
            VisualFormatConstraintOptions(string: "H:|[button]|"),
			VisualFormatConstraintOptions(string: "V:|-top-[title][subtitle][button(==buttonH)]")
		]
	}
	
	static func visualFormatMetrics() -> [String: AnyObject]? {
	
        return ["top" : 20, "buttonH" : 44]
	}
	
    static func layoutConstraints() -> [ConstraintOptions]? {
    
        return [
            ConstraintOptions(identifier: "titleHeight", itemIdentifier: "title", attribute: .Height, relatedBy: .Equal, toItemIdentifier: nil, attribute: .Height, multiplier: 1, constant: 100)
        ]
    }
}


class MyViewController: LazyBaseViewController <MyConf> {

	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		view.backgroundColor = .whiteColor()
        
        if let label: UILabel = element("title") {
        
            label.text = "Bonjour"
        }
        
        if let constraint = layoutConstaint("titleHeight") {
            
            constraint.constant = 200
        }
	}
}



