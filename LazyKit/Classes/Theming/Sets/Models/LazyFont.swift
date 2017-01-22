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
    
    func parseFontNames(_ string:String) -> String {
		
        let cleanString = string.replacingOccurrences(of: "\"", with: "").trimmingCharacters(in: .whitespaces)
        let components = cleanString.components(separatedBy: ",")
		
        return components[0].trimmingCharacters(in: .whitespaces)
    }
    
    func font() -> UIFont! {
		
        if let fontName = fontName, let fontSize = fontSize?.value {
			
            return UIFont(name: fontName, size: fontSize)
			
        } else if let fontName = fontName {
			
            return UIFont(name: fontName, size: 12)
			
        } else if let fontSize = fontSize?.value {
			
            return UIFont.systemFont(ofSize: fontSize)
        }
		
        return UIFont.systemFont(ofSize: 12)
    }

}
