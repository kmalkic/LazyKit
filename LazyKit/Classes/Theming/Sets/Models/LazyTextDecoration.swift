//
//  LazyTextDecoration.swift
//  LazyKit
//
//  Created by Kevin Malkic on 30/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal class LazyTextDecoration {
   
    var underline: LazyBool?
    var strikethrough: LazyBool?
    var color: LazyColor?
    
	func setup(_ string: String) {
		
		switch string {
		
		case "none":
			underline = false
			strikethrough = false
			
		case "underline":
			underline = true
			strikethrough = false
			
		case "line-through":
			strikethrough = true
			underline = false
			
		default:
			break
		}
	}
}



