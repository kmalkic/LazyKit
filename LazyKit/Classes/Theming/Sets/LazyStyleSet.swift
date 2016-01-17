//
//  StyleSet.swift
//  LazyKit
//
//  Created by Kevin Malkic on 22/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

class LazyStyleSet : NSObject {
   
    var patterns = [String]()
    
    var basicSet: LazyBasicSet?
    var textSet: LazyTextSet?
    var decorationSet: LazyDecorationSet?
    var optionSet: LazyOptionSet?
    var boxSet: LazyBoxSet?
    
    override init() {
        
    }
    
    init(elementName: String!, content: [String]!, variables: [String: String]?) {
        
        let separatedPatterns = elementName.componentsSeparatedByString(",")
                
        for (pattern) in separatedPatterns {
            
            patterns.append(pattern.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        }
        
        basicSet        = LazyBasicSet(content: content, variables: variables)
        textSet         = LazyTextSet(content: content, variables: variables)
        decorationSet   = LazyDecorationSet(content: content, variables: variables)
        optionSet       = LazyOptionSet(content: content, variables: variables)
        boxSet          = LazyBoxSet(content: content, variables: variables)
    }
    
}


func + (left:LazyStyleSet?, right:LazyStyleSet? ) -> LazyStyleSet? {
    
    if left == nil && right == nil { return nil }
    
    var object = LazyStyleSet()
    
    object.basicSet         = left?.basicSet + right?.basicSet
    
    object.decorationSet    = left?.decorationSet + right?.decorationSet
    
    object.optionSet        = left?.optionSet + right?.optionSet
    
    object.textSet          = left?.textSet + right?.textSet
    
    object.boxSet           = left?.boxSet + right?.boxSet
    
    return object
}