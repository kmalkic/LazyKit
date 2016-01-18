//
//  LazyFont.swift
//  LazyKit
//
//  Created by Kevin Malkic on 23/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

class LazyFont {
   
    var fontName: LazyString?
    
    var fontSize: LazyMeasure?
    
    func parseFontNames(string:String) -> String {
        let cleanString = string.stringByReplacingOccurrencesOfString("\"", withString: "").stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
        let components = cleanString.componentsSeparatedByString(",")
        return components[0].stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
    }
    
    func font() -> UIFont! {
        if fontName != nil && fontSize != nil {
            return UIFont(name: fontName!, size: fontSize!.value!)
        }
        else if fontName != nil {
            return UIFont(name: fontName!, size: 12)
        }
        else if fontSize != nil {
            return UIFont.systemFontOfSize(fontSize!.value!)
        }
        return UIFont.systemFontOfSize(12)
    }

}
