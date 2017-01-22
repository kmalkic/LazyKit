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
					
					return newImage.withRenderingMode(.alwaysTemplate)
				}
				
				return newImage
			}
		}
		
		return nil
	}()
	
    var imageName: LazyString?
    
    var tintColor: LazyColor?
    
    var contentMode: LazyViewContentMode?
    
    func setupContentModeWithString(_ string: String) {
		
		switch string {
		
		case "scaleToFit":
			contentMode = .scaleAspectFit
			
		case "scaleToFill":
			contentMode = .scaleAspectFill
			
		case "center":
			contentMode = .center
			
		case "top":
			contentMode = .top
			
		case "left":
			contentMode = .left
			
		case "bottom":
			contentMode = .bottom
		
		case "right":
			contentMode = .right
			
		default:
			contentMode = .scaleAspectFill
		}
    }
}
