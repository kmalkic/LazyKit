//
//  ElementOptions.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

public protocol ElementOptions: Equatable {
    
    typealias U
}

//MARK: - Element options protocol

public struct BaseOptions<T> {
    
    public typealias U = T
    
    var identifier: String?
    var classType: T.Type = T.self
    var styleClass: String?
    var styleId: String?
    
    public init(identifier: String? = nil, classType: T.Type = T.self, styleClass: String? = nil, styleId: String? = nil) {
    
        self.identifier = identifier
        self.classType = classType
        self.styleClass = styleClass
        self.styleId = styleId
    }
    

}

//MARK: - View options

public struct ViewOptions<T: UIView>: ElementOptions {
    
    public typealias U = T
    
    public var baseOptions: BaseOptions<T>?
    public var viewBaseOptions: ViewBaseOptions?
    
    public init(identifier: String? = nil, classType: T.Type = T.self, viewBaseOptions: ViewBaseOptions? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
        self.viewBaseOptions = viewBaseOptions
    }
    
    public init(identifier: String? = nil, classType: T.Type = T.self, styleClass: String? = nil, styleId: String? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
    }
    
    func == (lhs: ViewOptions<UIView>, rhs: ViewOptions<UIView>) -> Bool {
    
    
    }
}

//MARK: - Label options

public struct LabelOptions<T: UILabel>: ElementOptions {
    
    public typealias U = T
    
    public var baseOptions: BaseOptions<T>?
    public var viewBaseOptions: ViewBaseOptions?
    public var textOptions: TextBaseOptions?
    
    public init(identifier: String? = nil, classType: T.Type = T.self, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
        self.viewBaseOptions = viewBaseOptions
        self.textOptions = textOptions
    }
    
    public init(identifier: String? = nil, classType: T.Type = T.self, text: String? = nil, styleClass: String? = nil, styleId: String? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
        self.textOptions = TextBaseOptions(text: text)
    }
}

//MARK: - Button options

public struct ButtonOptions<T: UIButton>: ElementOptions {
    
    public typealias U = T
    
    public var baseOptions: BaseOptions<T>?
    public var viewBaseOptions: ViewBaseOptions?
    public var textOptionsForType: [LazyControlState: TextBaseOptions]?
    public var imageOptionsForType: [LazyControlState: ImageBaseOptions]?
    
    public var type: UIButtonType

    public init(identifier: String? = nil, classType: T.Type = T.self, type: UIButtonType = .Custom, viewBaseOptions: ViewBaseOptions? = nil, textOptionsForType: [LazyControlState: TextBaseOptions]? = nil, imageOptionsForType: [LazyControlState: ImageBaseOptions]? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
        self.viewBaseOptions = viewBaseOptions
        self.textOptionsForType = textOptionsForType
        self.imageOptionsForType = imageOptionsForType
        self.type = type
    }
    
    public init(identifier: String? = nil, classType: T.Type = T.self, type: UIButtonType = .Custom, texts: [LazyControlState: String]? = nil, styleClass: String? = nil, styleId: String? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
        
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

//MARK: - Image options

public struct ImageOptions<T: UIImageView>: ElementOptions {
    
    public typealias U = T
    
    public var baseOptions: BaseOptions<T>?
    public var viewBaseOptions: ViewBaseOptions?
    public var imageBaseOptions: ImageBaseOptions?

    public init(identifier: String? = nil, classType: T.Type = T.self, viewBaseOptions: ViewBaseOptions? = nil, imageBaseOptions: ImageBaseOptions? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
        self.viewBaseOptions = viewBaseOptions
        self.imageBaseOptions = imageBaseOptions
    }
    
    public init(identifier: String? = nil, classType: T.Type = T.self, styleClass: String? = nil, styleId: String? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
    }
}

//MARK: - TextField options

public struct TextFieldOptions<T: UITextField>: ElementOptions {
    
    public typealias U = T
    
    public var baseOptions: BaseOptions<T>?
    public var viewBaseOptions: ViewBaseOptions?
    public var textOptions: TextBaseOptions?
    public var placeholderOptions: TextBaseOptions?
    public var textInputOptions: TextInputBaseOptions?
    public var borderStyle: UITextBorderStyle?
    
    public init(identifier: String? = nil, classType: T.Type = T.self, borderStyle: UITextBorderStyle? = nil, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil, placeholderOptions: TextBaseOptions? = nil, textInputOptions: TextInputBaseOptions? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
        self.viewBaseOptions = viewBaseOptions
        self.textOptions = textOptions
        self.borderStyle = borderStyle
        self.placeholderOptions = placeholderOptions
        self.textInputOptions = textInputOptions
    }
    
    public init(identifier: String? = nil, classType: T.Type = T.self, borderStyle: UITextBorderStyle? = nil, text: String? = nil, placeholderText: String? = nil, styleClass: String? = nil, styleId: String? = nil, textInputOptions: TextInputBaseOptions? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
        self.borderStyle = borderStyle
        self.textOptions = TextBaseOptions(text: text)
        self.placeholderOptions = TextBaseOptions(text: placeholderText)
        self.textInputOptions = textInputOptions
    }
}

//MARK: - TextView options

public struct TextViewOptions<T: UITextView>: ElementOptions {
    
    public typealias U = T
    
    public var baseOptions: BaseOptions<T>?
    public var viewBaseOptions: ViewBaseOptions?
    public var textOptions: TextBaseOptions?
    public var textInputOptions: TextInputBaseOptions?
    
    public init(identifier: String? = nil, classType: T.Type = T.self, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil, textInputOptions: TextInputBaseOptions? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
        self.viewBaseOptions = viewBaseOptions
        self.textOptions = textOptions
        self.textInputOptions = textInputOptions
    }
    
    public init(identifier: String? = nil, classType: T.Type = T.self, text: String? = nil, styleClass: String? = nil, styleId: String? = nil, textInputOptions: TextInputBaseOptions? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
        self.textOptions = TextBaseOptions(text: text)
        self.textInputOptions = textInputOptions
    }
}

//MARK: - TableView options

public struct TableViewOptions<T: UITableView>: ElementOptions {
    
    public typealias U = T
    
    public var baseOptions: BaseOptions<T>?
    public var viewBaseOptions: ViewBaseOptions?
    public var style: UITableViewStyle = .Plain

    public init(identifier: String? = nil, classType: T.Type = T.self, style: UITableViewStyle = .Plain, viewBaseOptions: ViewBaseOptions? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
        self.viewBaseOptions = viewBaseOptions
        self.style = style
    }
    
    public init(identifier: String? = nil, classType: T.Type = T.self, style: UITableViewStyle = .Plain, styleClass: String? = nil, styleId: String? = nil) {
        
        self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
        self.style = style
    }
}

//MARK: - TableView options

public struct CollectionViewOptions<T: UICollectionView>: ElementOptions {
	
    public typealias U = T
    
	public var baseOptions: BaseOptions<T>?
	public var viewBaseOptions: ViewBaseOptions?
	public var collectionViewLayoutType = UICollectionViewLayout.self
	
	public init(identifier: String? = nil, classType: T.Type = T.self, collectionViewLayoutType: UICollectionViewLayout.Type = UICollectionViewLayout.self, viewBaseOptions: ViewBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.collectionViewLayoutType = collectionViewLayoutType
	}
	
	public init(identifier: String? = nil, classType: T.Type = T.self, collectionViewLayoutType: UICollectionViewLayout.Type = UICollectionViewLayout.self, styleClass: String? = nil, styleId: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleClass: styleClass, styleId: styleId)
		self.collectionViewLayoutType = collectionViewLayoutType
	}
}