//
//  ElementOptions.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

//MARK: Element options

public protocol ElementOptions {
    
    var identifier: String? { get set }
    var viewBaseOptions: ViewBaseOptions? { get set }
    
    var styleClass: String? { get set }
    var styleId: String? { get set }
}

public struct ViewOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UIView.self
    public var viewBaseOptions: ViewBaseOptions?
    
    public var styleClass: String?
    public var styleId: String?
    
    public init(identifier: String? = nil, classType: UIView.Type = UIView.self, viewBaseOptions: ViewBaseOptions? = nil) {
        
        self.identifier = identifier
        self.viewBaseOptions = viewBaseOptions
        self.classType = classType
    }
    
    public init(identifier: String? = nil, classType: UIView.Type = UIView.self, styleClass: String? = nil, styleId: String? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.styleClass = styleClass
        self.styleId = styleId
        
        self.viewBaseOptions = nil
    }
}

public struct LabelOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UILabel.self
    public var viewBaseOptions: ViewBaseOptions?
    public var textOptions: TextBaseOptions?
    
    public var styleClass: String?
    public var styleId: String?
    
    public init(identifier: String? = nil, classType: UILabel.Type = UILabel.self, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.viewBaseOptions = viewBaseOptions
        self.textOptions = textOptions
    }
    
    public init(identifier: String? = nil, classType: UILabel.Type = UILabel.self, text: String? = nil, styleClass: String? = nil, styleId: String? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.styleClass = styleClass
        self.styleId = styleId
        
        self.viewBaseOptions = nil
        self.textOptions = TextBaseOptions(text: text)
    }
}

public struct ButtonOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UIButton.self
    public var viewBaseOptions: ViewBaseOptions?
    public var textOptionsForType: [LazyControlState: TextBaseOptions]?
    public var imageOptionsForType: [LazyControlState: ImageBaseOptions]?
    
    public var type: UIButtonType
    
    public var styleClass: String?
    public var styleId: String?
    
    public init(identifier: String? = nil, classType: UIButton.Type = UIButton.self, type: UIButtonType = .Custom, viewBaseOptions: ViewBaseOptions? = nil, textOptionsForType: [LazyControlState: TextBaseOptions]? = nil, imageOptionsForType: [LazyControlState: ImageBaseOptions]? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.viewBaseOptions = viewBaseOptions
        self.textOptionsForType = textOptionsForType
        self.imageOptionsForType = imageOptionsForType
        self.type = type
    }
    
    public init(identifier: String? = nil, classType: UIButton.Type = UIButton.self, type: UIButtonType = .Custom, texts: [LazyControlState: String]? = nil, styleClass: String? = nil, styleId: String? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.styleClass = styleClass
        self.styleId = styleId
        
        self.viewBaseOptions = nil
        
        if let texts = texts {
            
            var textOptionsForType = [LazyControlState: TextBaseOptions]()
            
            for (state, text) in texts {
                
                textOptionsForType[state] = TextBaseOptions(text: text)
            }
            
            self.textOptionsForType = textOptionsForType
        }
        
        self.type = type
    }
}

public struct ImageOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UIImageView.self
    public var viewBaseOptions: ViewBaseOptions?
    public var imageBaseOptions: ImageBaseOptions?
    
    public var styleClass: String?
    public var styleId: String?
    
    public init(identifier: String? = nil, classType: UIImageView.Type = UIImageView.self, viewBaseOptions: ViewBaseOptions? = nil, imageBaseOptions: ImageBaseOptions? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.viewBaseOptions = viewBaseOptions
        self.imageBaseOptions = imageBaseOptions
    }
    
    public init(identifier: String? = nil, classType: UIImageView.Type = UIImageView.self, styleClass: String? = nil, styleId: String? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.styleClass = styleClass
        self.styleId = styleId
        self.viewBaseOptions = nil
        self.imageBaseOptions = nil
    }
}

public struct TextFieldOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UITextField.self
    public var viewBaseOptions: ViewBaseOptions?
    public var textOptions: TextBaseOptions?
    public var placeholderOptions: TextBaseOptions?
    public var textInputOptions: TextInputBaseOptions?
    
    public var borderStyle: UITextBorderStyle?
    
    public var styleClass: String?
    public var styleId: String?
    
    public init(identifier: String? = nil, classType: UITextField.Type = UITextField.self, borderStyle: UITextBorderStyle? = nil, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil, placeholderOptions: TextBaseOptions? = nil, textInputOptions: TextInputBaseOptions? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        
        self.viewBaseOptions = viewBaseOptions
        self.textOptions = textOptions
        self.borderStyle = borderStyle
        self.placeholderOptions = placeholderOptions
        self.textInputOptions = textInputOptions
    }
    
    public init(identifier: String? = nil, classType: UITextField.Type = UITextField.self, borderStyle: UITextBorderStyle? = nil, text: String? = nil, placeholderText: String? = nil, styleClass: String? = nil, styleId: String? = nil, textInputOptions: TextInputBaseOptions? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.styleClass = styleClass
        self.styleId = styleId
        
        self.borderStyle = borderStyle
        self.viewBaseOptions = nil
        self.textOptions = TextBaseOptions(text: text)
        self.placeholderOptions = TextBaseOptions(text: placeholderText)
        self.textInputOptions = textInputOptions
    }
}

public struct TextViewOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UITextView.self
    public var viewBaseOptions: ViewBaseOptions?
    public var textOptions: TextBaseOptions?
    public var textInputOptions: TextInputBaseOptions?
    
    public var styleClass: String?
    public var styleId: String?
    
    public init(identifier: String? = nil, classType: UITextView.Type = UITextView.self, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil, textInputOptions: TextInputBaseOptions? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.viewBaseOptions = viewBaseOptions
        self.textOptions = textOptions
        self.textInputOptions = textInputOptions
    }
    
    public init(identifier: String? = nil, classType: UITextView.Type = UITextView.self, text: String? = nil, styleClass: String? = nil, styleId: String? = nil, textInputOptions: TextInputBaseOptions? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.styleClass = styleClass
        self.styleId = styleId
        self.viewBaseOptions = nil
        self.textOptions = TextBaseOptions(text: text)
        self.textInputOptions = textInputOptions
    }
}

public struct TableViewOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UITableView.self
    public var viewBaseOptions: ViewBaseOptions?
    public var style: UITableViewStyle = .Plain
    public var styleClass: String?
    public var styleId: String?
    
    public init(identifier: String? = nil, classType: UITableView.Type = UITableView.self, style: UITableViewStyle = .Plain, viewBaseOptions: ViewBaseOptions? = nil) {
        
        self.identifier = identifier
        self.viewBaseOptions = viewBaseOptions
        self.classType = classType
        self.style = style
    }
    
    public init(identifier: String? = nil, classType: UITableView.Type = UITableView.self, style: UITableViewStyle = .Plain, styleClass: String? = nil, styleId: String? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.styleClass = styleClass
        self.styleId = styleId
        self.style = style
    }
}