//
//  StyleSet.swift
//  LazyKit
//
//  Created by Kevin Malkic on 22/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal class LazyStyleSet : NSObject {
   
    var patterns = [String]()
    
    var basicSet: LazyBasicSet?
    var textSet: LazyTextSet?
    var placeholderSet: LazyTextSet?
    var decorationSet: LazyDecorationSet?
    var optionSet: LazyOptionSet?
    
    override init() {
        
    }
    
    init(elementName: String!, content: [String]!, variables: [String: String]?) {
        
        let separatedPatterns = elementName.componentsSeparatedByString(",")
                
        for (pattern) in separatedPatterns {
            
            patterns.append(pattern.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        }
        
        basicSet        = LazyBasicSet(content: content, variables: variables)
        textSet         = LazyTextSet(content: content, variables: variables)
        placeholderSet  = LazyTextSet(content: content, variables: variables, textSearchMode: .Placeholder)
        decorationSet   = LazyDecorationSet(content: content, variables: variables)
        optionSet       = LazyOptionSet(content: content, variables: variables)
    }
}