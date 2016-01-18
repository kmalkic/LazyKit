//
//  LazyBorder.swift
//  LazyKit
//
//  Created by Malkic Kevin on 26/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

enum LazyBorderSide: Int {
    case Top
    case Left
    case Bottom
    case Right
}

class LazyBorder: LazyMeasure {
    
    var color: LazyColor?

    init(widthString: String, colorString: String?) {
        super.init(string: widthString)
        if colorString != nil {
            color = LazyColor(anyString: colorString!)
        }
    }
    
    override init(string: String) {
        super.init(string: string)
        value = CGFloat(self.valueFromString(string))
        unit = self.unitFromString(string)
    }
    
    init(colorString: String) {
        super.init()
        setupColor(colorString)
    }
    
    func setupColor(colorString: String) {
        color = LazyColor(anyString: colorString)
    }
}

let kBorderWidthRegex = "([0-9px]+)"

class LazyBorders {
   
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
    
    //Borders
    func setupBorder(key:String, value:String) {
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kBorderWidthRegex)$", text: value) ) {
            assignBorderSettingToAllBorders(width: components[0], color: "#000", replace: true)
            return
        }
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kBorderWidthRegex) (rga|rgba|#+)(.*)$", text: value) ) {
            assignBorderSettingToAllBorders(width: components[0], color: components[1], replace: true)
            return
        }
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kBorderWidthRegex) ([a-zA-Z]+) (rga|rgba|#+)(.*)$", text: value) ) {
            assignBorderSettingToAllBorders(width: components[0], color: components[2], replace: true)
            return
        }
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kBorderWidthRegex) \(kBorderWidthRegex) ([a-zA-Z]+) (rga|rgba|#+)(.*)$", text: value) ) {
            assignBorderSettingToAllBorders(topWidth: components[0], bottomWidth: components[0], leftWidth: components[1], rightWidth: components[1], color: components[2])
            return
        }
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex) ([a-zA-Z]+) (rga|rgba|#+)(.*)$", text: value) ) {
            assignBorderSettingToAllBorders(topWidth: components[0], bottomWidth: components[1], leftWidth: components[2], rightWidth: components[3], color: components[5])
            return
        }
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex) (rga|rgba|#+)(.*)$", text: value) ) {
            assignBorderSettingToAllBorders(topWidth: components[0], bottomWidth: components[1], leftWidth: components[2], rightWidth: components[3], color: components[4])
            return
        }
    }
    
    func setupBorderWidth(key:String, value:String) {
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kBorderWidthRegex)$", text: value) ) {
            assignBorderSettingToAllBorders(width: components[0], color: nil, replace: false)
            return
        }
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kBorderWidthRegex) \(kBorderWidthRegex)$", text: value) ) {
            assignBorderSettingToAllBorders(topWidth: components[0], bottomWidth: components[0], leftWidth: components[1], rightWidth: components[1], color: nil)
            return
        }
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex)$", text: value) ) {
            assignBorderSettingToAllBorders(topWidth: components[0], bottomWidth: components[1], leftWidth: components[2], rightWidth: components[3], color: nil)
            return
        }
    }
    
    func setupBorderColor(key:String, value:String) {
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^(rga|rgba|#+)(.*)$", text: value) ) {
            assignBorderSettingToAllBorders(width: nil, color: components[0], replace: false)
            return
        }
    }
    
    private func splitComponentsFromMatches(matches:[String]?) -> [String]? {
        
        if let matches = matches {
            
            if matches.count > 0 {
                
                return matches[0].componentsSeparatedByString(" ")
            }
        }
        
        return nil
    }
    
    private func assignBorderSettingToAllBorders(width width: String?, color: String?, replace: Bool) {
        if width != nil && color != nil {
            top = LazyBorder(widthString: width!, colorString: color!)
            left = LazyBorder(widthString: width!, colorString: color!)
            bottom = LazyBorder(widthString: width!, colorString: color!)
            right = LazyBorder(widthString: width!, colorString: color!)
        }
        else if width != nil {
            if replace == true {
                top = LazyBorder(string: width!)
                left = LazyBorder(string: width!)
                bottom = LazyBorder(string: width!)
                right = LazyBorder(string: width!)
            } else {
                if top == nil       { top = LazyBorder(string: width!)    } else { top!.setup(width!) }
                if left == nil      { left = LazyBorder(string: width!)   } else { left?.setup(width!) }
                if bottom == nil    { bottom = LazyBorder(string: width!) } else { bottom!.setup(width!) }
                if right == nil     { right = LazyBorder(string: width!)  } else { right?.setup(width!) }
            }
        }
        else if (color != nil) {
            if replace == true {
                top = LazyBorder(colorString: color!)
                left = LazyBorder(colorString: color!)
                bottom = LazyBorder(colorString: color!)
                right = LazyBorder(colorString: color!)
            } else {
                if top == nil    { top = LazyBorder(colorString: color!)    } else { top!.setupColor(color!) }
                if left == nil   { left = LazyBorder(colorString: color!)   } else { left?.setupColor(color!) }
                if bottom == nil { bottom = LazyBorder(colorString: color!) } else { bottom!.setupColor(color!) }
                if right == nil  { right = LazyBorder(colorString: color!)  } else { right?.setupColor(color!) }
            }
        }
    }
    
    private func assignBorderSettingToAllBorders(topWidth topWidth:String, bottomWidth:String, leftWidth:String, rightWidth:String, color:String?) {
        
        top = LazyBorder(widthString: topWidth, colorString: color)
        left = LazyBorder(widthString: leftWidth, colorString: color)
        bottom = LazyBorder(widthString: bottomWidth, colorString: color)
        right = LazyBorder(widthString: rightWidth, colorString: color)
    }
    
    func isBordersWidthZero() -> Bool {
        
        if top == nil {
            
            return true
        }
        
        return (top?.value == 0 && left?.value == 0 && bottom?.value == 0 && right?.value == 0)
    }
    
    func highiestBorderWidth() -> LazyMeasure {
        
        let values = [top, left, bottom, right]
        
        let result = values.sort { (a, b) -> Bool in
            
            return (a!.value > b!.value)
        }

        return result.first!!
    }
    
    //Radius
    func setupBorderRadius(key:String, value:String) {
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kBorderWidthRegex)$", text: value) ) {
            
            assignBorderRadiusSettingToAllBorders(radius: components[0])
            return
        }
        
        if let components = splitComponentsFromMatches( matchesForRegexInText("^\(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex) \(kBorderWidthRegex)$", text: value) ) {
            assignBorderRadiusSettingToAllBorders(topRadius: components[0], bottomRadius: components[1], leftRadius: components[2], rightRadius: components[3])
            return
        }
    }
    
    private func assignBorderRadiusSettingToAllBorders(radius radius:String) {
        
        cornerRadiusTopRight = LazyMeasure(string: radius)
        cornerRadiusTopLeft = LazyMeasure(string: radius)
        cornerRadiusBottomRight = LazyMeasure(string: radius)
        cornerRadiusBottomLeft = LazyMeasure(string: radius)
        rectCorner = .AllCorners
    }
    
    private func assignBorderRadiusSettingToAllBorders(topRadius topRadius:String, bottomRadius:String, leftRadius:String, rightRadius:String) {
        
        cornerRadiusTopRight = LazyMeasure(string: topRadius)
        cornerRadiusTopLeft = LazyMeasure(string: bottomRadius)
        cornerRadiusBottomRight = LazyMeasure(string: leftRadius)
        cornerRadiusBottomLeft = LazyMeasure(string: rightRadius)
        
        rectCorner = nil
        
        if cornerRadiusTopRight!.value > 0 {

            if rectCorner == nil { rectCorner = .TopRight } else { rectCorner = [rectCorner!, .TopRight] }
        }
        
        if cornerRadiusTopLeft!.value > 0 {
            
            if rectCorner == nil { rectCorner = .TopLeft } else { rectCorner = [rectCorner!, .TopLeft] }
        }
        
        if cornerRadiusBottomRight!.value > 0 {
            
            if rectCorner == nil { rectCorner = .BottomRight } else { rectCorner = [rectCorner!, .BottomRight] }
        }
        
        if cornerRadiusBottomLeft!.value > 0 {
            
            if rectCorner == nil { rectCorner = .BottomLeft } else { rectCorner = [rectCorner!, .BottomLeft] }
        }
    }
    
    func hasCornerRadius() -> Bool {
        
        return (cornerRadiusBottomLeft?.value > 0 || cornerRadiusBottomRight?.value > 0 || cornerRadiusTopLeft?.value > 0 || cornerRadiusTopRight?.value > 0)
    }
    
    func isCornersRadiusEqual() -> Bool {
        
        return (cornerRadiusBottomLeft?.value == cornerRadiusBottomRight?.value && cornerRadiusTopLeft?.value == cornerRadiusBottomRight?.value && cornerRadiusTopRight?.value == cornerRadiusBottomRight?.value)
    }
    
    func highiestRadius() -> LazyMeasure {
        
        let values = [cornerRadiusBottomLeft, cornerRadiusBottomRight, cornerRadiusTopLeft, cornerRadiusTopRight]
        
        let result = values.sort({ (a, b) -> Bool in
            
            return (a!.value > b!.value)
        })
        
        return result.first!!
    }
}

func + (left:LazyBorders?, right:LazyBorders? ) -> LazyBorders? {
    
    if left == nil && right == nil { return nil }
    
    var object:LazyBorders?
    
    if right != nil { object = right } else { object = left }
    
    return object
}
