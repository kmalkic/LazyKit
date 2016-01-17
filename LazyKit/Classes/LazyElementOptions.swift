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
}

public struct ViewOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UIView.self
    public var viewBaseOptions: ViewBaseOptions?
    
    public init(identifier: String? = nil, classType: UIView.Type = UIView.self, viewBaseOptions: ViewBaseOptions? = nil) {
        
        self.identifier = identifier
        self.viewBaseOptions = viewBaseOptions
        self.classType = classType
    }
}

public struct LabelOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UILabel.self
    public var viewBaseOptions: ViewBaseOptions?
    public let textOptions: TextBaseOptions?
    
    public init(identifier: String? = nil, classType: UILabel.Type = UILabel.self, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil) {
        
        self.identifier = identifier
        self.viewBaseOptions = viewBaseOptions
        self.textOptions = textOptions
        self.classType = classType
    }
}

public struct ButtonOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UIButton.self
    public var viewBaseOptions: ViewBaseOptions?
    public let textOptionsForType: [UIControlState: TextBaseOptions]?
    
    public let type: UIButtonType
    
    public init(identifier: String? = nil, classType: UIButton.Type = UIButton.self, type: UIButtonType = .Custom, viewBaseOptions: ViewBaseOptions? = nil, textOptionsForType: [UIControlState: TextBaseOptions]? = nil) {
        
        self.identifier = identifier
        self.viewBaseOptions = viewBaseOptions
        self.textOptionsForType = textOptionsForType
        self.type = type
        self.classType = classType
    }
}

public struct ImageOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UIImageView.self
    public var viewBaseOptions: ViewBaseOptions?
    public let imageBaseOptions: ImageBaseOptions?
    
    public init(identifier: String? = nil, classType: UIImageView.Type = UIImageView.self, viewBaseOptions: ViewBaseOptions? = nil, imageBaseOptions: ImageBaseOptions? = nil) {
        
        self.identifier = identifier
        self.classType = classType
        self.viewBaseOptions = viewBaseOptions
        self.imageBaseOptions = imageBaseOptions
    }
}

public struct TextFieldOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UITextField.self
    public var viewBaseOptions: ViewBaseOptions?
    public let textOptions: TextBaseOptions?
    public let placeholderOptions: TextBaseOptions?
    public let textInputOptions: TextInputBaseOptions?
    
    public let borderStyle: UITextBorderStyle?
    
    public init(identifier: String? = nil, classType: UITextField.Type = UITextField.self, borderStyle: UITextBorderStyle? = nil, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil, placeholderOptions: TextBaseOptions? = nil, textInputOptions: TextInputBaseOptions? = nil) {
        
        self.identifier = identifier
        self.viewBaseOptions = viewBaseOptions
        self.textOptions = textOptions
        self.classType = classType
        self.borderStyle = borderStyle
        self.placeholderOptions = placeholderOptions
        self.textInputOptions = textInputOptions
    }
}

public struct TextViewOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UITextView.self
    public var viewBaseOptions: ViewBaseOptions?
    public let textOptions: TextBaseOptions?
    public let textInputOptions: TextInputBaseOptions?
    
    public init(identifier: String? = nil, classType: UITextView.Type = UITextView.self, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil, textInputOptions: TextInputBaseOptions? = nil) {
        
        self.identifier = identifier
        self.viewBaseOptions = viewBaseOptions
        self.textOptions = textOptions
        self.classType = classType
        self.textInputOptions = textInputOptions
    }
}

public struct TableViewOptions : ElementOptions {
    
    public var identifier: String?
    public var classType = UITableView.self
    public var viewBaseOptions: ViewBaseOptions?
    public var style: UITableViewStyle = .Plain
    
    public init(identifier: String? = nil, classType: UITableView.Type = UITableView.self, style: UITableViewStyle = .Plain, viewBaseOptions: ViewBaseOptions? = nil) {
        
        self.identifier = identifier
        self.viewBaseOptions = viewBaseOptions
        self.classType = classType
        self.style = style
    }
}