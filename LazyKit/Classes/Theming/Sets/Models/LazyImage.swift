//
//  LazyImage.swift
//  LazyKit
//
//  Created by Kevin Malkic on 27/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal class LazyImage {
   
	lazy var image: UIImage? = {
		
		if let imageName = self.imageName {
			
			if let newImage = UIImage(named: imageName) {
				
				if self.tintColor != nil {
					
					return newImage.imageWithRenderingMode(.AlwaysTemplate)
				}
				
				return newImage
			}
		}
		
		return nil
	}()
	
    var imageName: LazyString?
    
    var tintColor: LazyColor?
    
    var contentMode: LazyViewContentMode?
    
    func setupContentModeWithString(string: String) {
		
		switch string {
		
		case "scaleToFit":
			contentMode = .ScaleAspectFit
			
		case "scaleToFill":
			contentMode = .ScaleAspectFill
			
		case "center":
			contentMode = .Center
			
		case "top":
			contentMode = .Top
			
		case "left":
			contentMode = .Left
			
		case "bottom":
			contentMode = .Bottom
		
		case "right":
			contentMode = .Right
			
		default:
			contentMode = .ScaleAspectFill
		}
    }
}
