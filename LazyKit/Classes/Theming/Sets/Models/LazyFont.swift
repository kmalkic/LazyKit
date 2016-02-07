//
//  LazyFont.swift
//  LazyKit
//
//  Created by Kevin Malkic on 23/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal class LazyFont {
   
    var fontName: LazyString?
    
    var fontSize: LazyMeasure?
    
    func parseFontNames(string:String) -> String {
		
        let cleanString = string.stringByReplacingOccurrencesOfString("\"", withString: "").stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
        let components = cleanString.componentsSeparatedByString(",")
		
        return components[0].stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
    }
    
    func font() -> UIFont! {
		
        if let fontName = fontName, fontSize = fontSize?.value {
			
            return UIFont(name: fontName, size: fontSize)
			
        } else if let fontName = fontName {
			
            return UIFont(name: fontName, size: 12)
			
        } else if let fontSize = fontSize?.value {
			
            return UIFont.systemFontOfSize(fontSize)
        }
		
        return UIFont.systemFontOfSize(12)
    }

}
