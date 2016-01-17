//
//  LazyEdges.swift
//  LazyKit
//
//  Created by Malkic Kevin on 18/05/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

let kEdgesRegex = "([0-9px]+|auto)"

class LazyEdges {
   
    var top : LazyMeasure?
    var left : LazyMeasure?
    var bottom : LazyMeasure?
    var right : LazyMeasure?
    
    init() {
        
    }
    
    init(string:String) {
        setupEdges(string)
    }
    
    func setupEdges(value:String) {
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kEdgesRegex)$", value) ) {
            top = LazyMeasure(string: components[0])
            left = LazyMeasure(string: components[0])
            bottom = LazyMeasure(string: components[0])
            right = LazyMeasure(string: components[0])
            return
        }
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kEdgesRegex) \(kEdgesRegex)$", value) ) {
            top = LazyMeasure(string: components[0])
            left = LazyMeasure(string: components[1])
            bottom = LazyMeasure(string: components[0])
            right = LazyMeasure(string: components[1])
            return
        }
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kEdgesRegex) \(kEdgesRegex) \(kEdgesRegex) \(kEdgesRegex)$", value) ) {
            top = LazyMeasure(string: components[0])
            left = LazyMeasure(string: components[1])
            bottom = LazyMeasure(string: components[2])
            right = LazyMeasure(string: components[3])
            return
        }
    }
    
    private func splitComponentsFromMatches(matches:[String]) -> [String]? {
        if matches.count > 0 {
            return matches[0].componentsSeparatedByString(" ")
        }
        return nil
    }
    
    func edgeInsets() -> UIEdgeInsets {
        let lTop    = (self.top?.value != nil) ? self.top!.value! : 0
        let lBottom = (self.bottom?.value != nil) ? self.bottom!.value! : 0
        let lLeft   = (self.left?.value != nil) ? self.left!.value! : 0
        let lRight  = (self.right?.value != nil) ? self.right!.value! : 0
        return UIEdgeInsetsMake(lTop, lLeft, lBottom, lRight)
    }
}


func + (left:LazyEdges?, right:LazyEdges? ) -> LazyEdges? {
    
    if left == nil && right == nil { return nil }
    
    var object = LazyEdges()
    
    object.top = left?.top + right?.top
    
    object.left = left?.left + right?.left
    
    object.bottom = left?.bottom + right?.bottom
    
    object.right = left?.right + right?.right
    
    return object
}