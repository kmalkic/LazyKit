//
//  LazyBorder.swift
//  LazyKit
//
//  Created by Malkic Kevin on 26/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


internal enum LazyBorderSide: Int {
    case top
    case left
    case bottom
    case right
}

let kBorderWidthRegex = "([0-9px]+)"
let kBorderTextRegex = "([a-zA-Z]+)"
let kBorderColorRegex = "(rga|rgba|#+)(.*)"

internal struct LazyStringBorderEdges {
	
	let top : String
	let left : String
	let bottom : String
	let right : String
	let color : String?
	
	init(top: String = "0", left: String? = nil, bottom: String? = nil, right: String? = nil, color: String? = nil) {
		
		self.top = top
		self.left = left ?? top
		self.bottom = bottom ?? top
		self.right = right ?? left ?? top
		self.color = color
	}
}

internal struct LazyStringBorderRadiusEdges {
	
	let topLeft : String
	let topRight : String
	let bottomRight : String
	let bottomLeft : String
	
	init(topLeft: String = "0", topRight: String? = nil, bottomRight: String? = nil, bottomLeft: String? = nil) {
		
		self.topLeft = topLeft
		self.topRight = topRight ?? topLeft
		self.bottomRight = bottomRight ?? topLeft
		self.bottomLeft = bottomLeft ?? topLeft
	}
}

internal class LazyBorder: LazyMeasure {
    
    var color: LazyColor?

    init(widthString: String? = nil, colorString: String? = nil) {
		
        super.init(string: widthString)
		color = LazyColor(anyString: colorString)
    }
	
    func setupColor(_ colorString: String?) {
		
        color = LazyColor(anyString: colorString)
    }
}

internal class LazyBorders {
   
    var top : LazyBorder?
    var left : LazyBorder?
    var bottom : LazyBorder?
    var right : LazyBorder?
    
    var cornerRadiusBottomLeft: LazyMeasure?
    var cornerRadiusBottomRight: LazyMeasure?
    var cornerRadiusTopLeft: LazyMeasure?
    var cornerRadiusTopRight: LazyMeasure?
    
    var rectCorner: UIRectCorner?
    
    init() {
        
    }
	
    //MARK: - Borders
	
    func setupBorder(_ key: String, value: String) {
		
		let regexes = [
			"^\(kBorderWidthRegex)$",
			"^\(kBorderWidthRegex) \(kBorderColorRegex)$",
			"^\(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderColorRegex)$",
			"^\(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderColorRegex)$",
		]
		
		threatBorders(regexes, value: value)
    }
    
    func setupBorderWidth(_ key:String, value:String) {
		
		let regexes = [
			"^\(kBorderWidthRegex)$",
			"^\(kBorderWidthRegex) \(kBorderWidthRegex)$",
			"^\(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex)$",
		]
		
		threatBorders(regexes, value: value)
    }
    
    func setupBorderColor(_ key:String, value:String) {
        
		let regexes = [
			"^\(kBorderColorRegex)$"
		]
		
		threatBorders(regexes, value: value)
    }
    
	fileprivate func threatBorders(_ regexes:[String], value:String) {
		
		for regex in regexes {
			
			if let stringEdges = stringBorderEdgesFromMatches( matchesForRegexInText(regex, text: value) ) {
				
				top = merge(left:top, right:LazyBorder(widthString: stringEdges.top, colorString: stringEdges.color))
				left = merge(left:left, right:LazyBorder(widthString: stringEdges.left, colorString: stringEdges.color))
				bottom = merge(left:bottom, right:LazyBorder(widthString: stringEdges.bottom, colorString: stringEdges.color))
				right = merge(left:right, right:LazyBorder(widthString: stringEdges.right, colorString: stringEdges.color))
				break
			}
		}
	}
	
	fileprivate func merge(left:LazyBorder?, right:LazyBorder) -> LazyBorder {
		
		let object = LazyBorder()
		object.color = right.color ?? left?.color
		object.value = right.value ?? left?.value
		object.unit = right.unit ?? left?.unit
		
		return object
	}
	
    func isBordersWidthZero() -> Bool {
		
        return (top?.value == 0 && left?.value == 0 && bottom?.value == 0 && right?.value == 0)
    }
    
    func highiestBorderWidth() -> LazyMeasure? {
        
		var values = [LazyMeasure](); if let top = top { values.append(top) }; if let left = left { values.append(left) }; if let bottom = bottom { values.append(bottom) }; if let right = right { values.append(right) };
        
        let result = values.sorted { (a, b) -> Bool in
            
            return (a.value > b.value)
        }

		guard let first = result.first else {
			
			return nil
		}
		
        return first
    }
    
    //MARK: - Radius
	
    func setupBorderRadius(_ key:String, value:String) {
		
		let regexes = [
			"^\(kBorderWidthRegex)$",
			"^\(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex)$",
		]
		
		threatBordersRadius(regexes, value: value)
    }
	
	fileprivate func threatBordersRadius(_ regexes:[String], value:String) {
		
		for regex in regexes {
			
			if let stringEdges = stringBorderRadiusEdgesFromMatches( matchesForRegexInText(regex, text: value) ) {
				
				cornerRadiusTopLeft = LazyMeasure(string: stringEdges.topLeft)
				cornerRadiusTopRight = LazyMeasure(string: stringEdges.topRight)
				cornerRadiusBottomRight = LazyMeasure(string: stringEdges.bottomRight)
				cornerRadiusBottomLeft = LazyMeasure(string: stringEdges.bottomLeft)
				break
			}
		}
		
		assignRectCorners()
	}
	
    fileprivate func assignRectCorners() {
		
        rectCorner = nil
        
		if cornerRadiusTopLeft?.value > 0 {
			
			if let rectCorner = rectCorner {
				
				self.rectCorner = [rectCorner, .topLeft]
				
			} else {
				
				rectCorner = .topLeft
			}
		}
		
		if cornerRadiusTopRight?.value > 0 {
			
			if let rectCorner = rectCorner {
				
				self.rectCorner = [rectCorner, .topRight]
				
			} else {
				
				rectCorner = .topRight
			}
		}
		
        if cornerRadiusBottomRight?.value > 0 {
			
            if let rectCorner = rectCorner {
				
				self.rectCorner = [rectCorner, .bottomRight]
				
			} else {
				
				rectCorner = .bottomRight
			}
        }
        
		if cornerRadiusBottomLeft?.value > 0 {
			
			if let rectCorner = rectCorner {
				
				self.rectCorner = [rectCorner, .bottomLeft]
				
			} else {
				
				rectCorner = .bottomLeft
			}
		}
    }
	
    func hasCornerRadius() -> Bool {
        
        return (cornerRadiusBottomLeft?.value > 0 || cornerRadiusBottomRight?.value > 0 || cornerRadiusTopLeft?.value > 0 || cornerRadiusTopRight?.value > 0)
    }
    
    func isCornersRadiusEqual() -> Bool {
        
        return (cornerRadiusBottomLeft?.value == cornerRadiusBottomRight?.value && cornerRadiusTopLeft?.value == cornerRadiusBottomRight?.value && cornerRadiusTopRight?.value == cornerRadiusBottomRight?.value)
    }
	
	func highiestBorderRadius() -> LazyMeasure? {
		
		var values = [LazyMeasure](); if let measure = cornerRadiusBottomLeft { values.append(measure) }; if let measure = cornerRadiusBottomRight { values.append(measure) }; if let measure = cornerRadiusTopRight { values.append(measure) }; if let measure = cornerRadiusTopLeft { values.append(measure) };
		
		let result = values.sorted { (a, b) -> Bool in
			
			return (a.value > b.value)
		}
		
		guard let first = result.first else {
			
			return nil
		}
		
		return first
	}
	
	//MARK: Utils
	
	fileprivate func stringBorderEdgesFromMatches(_ matches:[String]?) -> LazyStringBorderEdges? {
		
		if let matches = matches {
			
			if let components = matches.first?.components(separatedBy: " ") {
				
				if matchesForRegexInText(kBorderColorRegex, text: components.last) != nil {
					
					switch components.count {
						
					case 1:
						return LazyStringBorderEdges(color: components.first)
						
					case 2:
						return LazyStringBorderEdges(top: components[0], color: components[1])
						
					case 3:
						return LazyStringBorderEdges(top: components[0], left: components[1], color: components[2])
						
					case 5:
						return LazyStringBorderEdges(top: components[0], left: components[1], bottom: components[2], right: components[3], color: components[4])
						
					default:
						break
					}
					
				} else if matchesForRegexInText(kBorderWidthRegex, text: components.last) != nil {
					
					switch components.count {
						
					case 1:
						return LazyStringBorderEdges(top: components.first!, color: "#000")
						
					case 2:
						return LazyStringBorderEdges(top: components[0], left: components[1], color: "#000")
						
					case 4:
						return LazyStringBorderEdges(top: components[0], left: components[1], bottom: components[2], right: components[3], color: "#000")
						
					default:
						break
					}
				}
			}
		}
		
		return nil
	}
	
	fileprivate func stringBorderRadiusEdgesFromMatches(_ matches:[String]?) -> LazyStringBorderRadiusEdges? {
		
		if let matches = matches {
			
			if let components = matches.first?.components(separatedBy: " ") {
				
				if matchesForRegexInText(kBorderWidthRegex, text: components.last) != nil {
					
					switch components.count {
						
					case 1:
						return LazyStringBorderRadiusEdges(topLeft: components.first!)
						
					case 4:
						return LazyStringBorderRadiusEdges(topLeft: components[0], topRight: components[1], bottomRight: components[2], bottomLeft: components[3])
						
					default:
						break
					}
				}
			}
		}
		
		return nil
	}
}
