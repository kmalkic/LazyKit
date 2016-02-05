//
//  LazyEdges.swift
//  LazyKit
//
//  Created by Malkic Kevin on 18/05/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

let kEdgesRegex = "([0-9px]+|auto)"

struct LazyStringEdges {
	
	let top : String
	let left : String
	let bottom : String
	let right : String
	
	init(top: String = "0", left: String? = nil, bottom: String? = nil, right: String? = nil) {
	
		self.top = top
		self.left = left ?? top
		self.bottom = bottom ?? top
		self.right = right ?? left ?? top
	}
}

class LazyEdges {
   
    var top : LazyMeasure?
    var left : LazyMeasure?
    var bottom : LazyMeasure?
    var right : LazyMeasure?
    
    init() {
        
    }
    
    init(string: String) {
		
		let regexes = ["^\(kEdgesRegex)$", "^\(kEdgesRegex) \(kEdgesRegex)$", "^\(kEdgesRegex) \(kEdgesRegex) \(kEdgesRegex) \(kEdgesRegex)$"]
		
		for regex in regexes {
			
			if let stringEdges = stringEdgesFromMatches( matchesForRegexInText(regex, text: string) ) {
				
				top = LazyMeasure(string: stringEdges.top)
				left = LazyMeasure(string: stringEdges.left)
				bottom = LazyMeasure(string: stringEdges.bottom)
				right = LazyMeasure(string: stringEdges.right)
			}
		}
    }
	
    private func stringEdgesFromMatches(matches:[String]?) -> LazyStringEdges? {
        
        if let matches = matches {
			
			if let components = matches.first?.componentsSeparatedByString(" ") {
			
				switch components.count {
				
				case 0:
					return nil
					
				case 1:
					return LazyStringEdges(top: components[0])
					
				case 2:
					return LazyStringEdges(top: components[0], left: components[1])
					
				case 4:
					return LazyStringEdges(top: components[0], left: components[1], bottom: components[2], right: components[3])
					
				default:
					break
				}
			}
        }
        
        return nil
    }
    
    func edgeInsets() -> UIEdgeInsets {
        
        let top    = self.top?.value ?? 0
        let bottom = self.bottom?.value ?? 0
        let left   = self.left?.value ?? 0
        let right  = self.right?.value ?? 0
		
        return UIEdgeInsetsMake(top, left, bottom, right)
    }
}
