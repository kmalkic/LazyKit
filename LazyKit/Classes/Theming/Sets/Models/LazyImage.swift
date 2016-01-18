//
//  LazyImage.swift
//  LazyKit
//
//  Created by Kevin Malkic on 27/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

class LazyImage {
   
    lazy var image: UIImage? = {
        if self.imageName != nil {
            let newImage = UIImage(named: self.imageName!)
            if self.tintColor != nil && newImage != nil {
                return newImage!.imageWithRenderingMode(.AlwaysTemplate)
            }
            return newImage
        }
        return nil
        }()
    
    var imageName: LazyString?
    
    var tintColor: LazyColor?
    
    var contentMode: LazyViewContentMode?
    
    func setupContentModeWithString(string: String) {
        
        if string == "scaleToFit" {
            contentMode = .ScaleAspectFit;
        }
        else if string == "scaleToFill" {
            contentMode = .ScaleAspectFill;
        }
        else if string == "center" {
            contentMode = .Center;
        }
        else if string == "top" {
            contentMode = .Top;
        }
        else if string == "left" {
            contentMode = .Left;
        }
        else if string == "bottom" {
            contentMode = .Bottom;
        }
        else if string == "right" {
            contentMode = .Right;
            
        } else {
            contentMode = .ScaleAspectFill
        }
    }
}


func + (left:LazyImage?, right:LazyImage? ) -> LazyImage? {
    
    if left == nil && right == nil { return nil }
    
    let object = LazyImage()
    
    object.contentMode = left?.contentMode + right?.contentMode
    
    object.imageName = left?.imageName + right?.imageName
    
    object.tintColor = left?.tintColor + right?.tintColor
    
    return object
}