//
//  ElementOptions.swift
//  LazyKit
//
//  Created by Kevin Malkic on 14/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

//MARK: - Element options protocol

///Base protocol that defines all view options
public protocol ElementOptions {
	
    /**
     Structure that contains UIView base properties
     */
	var viewBaseOptions: ViewBaseOptions? { get set }
    /**
     Get the css identifiers
     
     - parameter block: A block that returns the styleId and styleClass
     */
	func getStyleIdentifiers(_ block: (_ styleId: String?, _ styleClass: String?) -> Void)
    /**
     Get the ui identifier 
     
     - parameter block: A block that returns the identifier
     */
	func getStyleIdentifier(_ block: (_ identifier: String) -> Void)
}

public extension ElementOptions {
	
	/**
	Get the css identifiers
	
	- parameter block: A block that returns the styleId and styleClass
	*/
	public func getStyleIdentifiers(_ block: (_ styleId: String?, _ styleClass: String?) -> Void) {
		
		switch self {
			
		case let elementOptions as LabelOptions:			block(elementOptions.baseOptions.styleId, elementOptions.baseOptions.styleClass)
		case let elementOptions as ButtonOptions:			block(elementOptions.baseOptions.styleId, elementOptions.baseOptions.styleClass)
		case let elementOptions as TextFieldOptions:		block(elementOptions.baseOptions.styleId, elementOptions.baseOptions.styleClass)
		case let elementOptions as TextViewOptions:			block(elementOptions.baseOptions.styleId, elementOptions.baseOptions.styleClass)
		case let elementOptions as ImageOptions:			block(elementOptions.baseOptions.styleId, elementOptions.baseOptions.styleClass)
		case let elementOptions as TableViewOptions:		block(elementOptions.baseOptions.styleId, elementOptions.baseOptions.styleClass)
		case let elementOptions as CollectionViewOptions:	block(elementOptions.baseOptions.styleId, elementOptions.baseOptions.styleClass)
		case let elementOptions as ViewOptions:				block(elementOptions.baseOptions.styleId, elementOptions.baseOptions.styleClass)
			
		default: break
		}
	}
	
	/**
	Get the ui identifier
	
	- parameter block: A block that returns the identifier
	*/
	public func getStyleIdentifier(_ block: (_ identifier: String) -> Void) {
		
		var identifier: String?
		
		switch self {
			
		case let elementOptions as LabelOptions:			identifier = elementOptions.baseOptions.identifier
		case let elementOptions as ButtonOptions:			identifier = elementOptions.baseOptions.identifier
		case let elementOptions as TextFieldOptions:		identifier = elementOptions.baseOptions.identifier
		case let elementOptions as TextViewOptions:			identifier = elementOptions.baseOptions.identifier
		case let elementOptions as ImageOptions:			identifier = elementOptions.baseOptions.identifier
		case let elementOptions as TableViewOptions:		identifier = elementOptions.baseOptions.identifier
		case let elementOptions as CollectionViewOptions:	identifier = elementOptions.baseOptions.identifier
		case let elementOptions as ViewOptions:				identifier = elementOptions.baseOptions.identifier
			
		default: break
		}
		
		if identifier != nil { block(identifier!) }
	}
}

//MARK: - Base options

///Generic structure that hold base properties
public struct BaseOptions<T> {
	
	public typealias ElementType = T
	
    /**
     A string that identifies the element.
     */
	var identifier: String?
    /**
     The class type
     */
	var classType: ElementType.Type = ElementType.self
    /**
     The css style class
     */
	var styleClass: String?
    /**
     The css style identifier
     */
	var styleId: String?
	
    /**
     Constructor
     */
	public init(identifier: String? = nil, classType: ElementType.Type = ElementType.self, styleId: String? = nil, styleClass: String? = nil) {
		
		self.identifier = identifier
		self.classType = classType
		self.styleClass = styleClass
		self.styleId = styleId
	}
}

//MARK: - View options

///Structure for UIView options
public struct ViewOptions: ElementOptions {
	
    /**
     Generic structure that hold base properties
     */
	public var baseOptions: BaseOptions<UIView>
    /**
     Structure for UIView base properties
     */
	public var viewBaseOptions: ViewBaseOptions?
	
    /**
     Options Constructor
     */
	public init(identifier: String? = nil, classType: UIView.Type = UIView.self, viewBaseOptions: ViewBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
	}
	
    /**
     CSS Constructor
     */
	public init(identifier: String? = nil, classType: UIView.Type = UIView.self, styleId: String? = nil, styleClass: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleId: styleId, styleClass: styleClass)
	}
}

//MARK: - Label options

///Structure for UILabel options
public struct LabelOptions: ElementOptions {
	
    /**
     Generic structure that hold base properties
     */
	public var baseOptions: BaseOptions<UILabel>
    /**
     Structure for UIView base properties
     */
	public var viewBaseOptions: ViewBaseOptions?
    /**
     Structure for UI elements that support UILabel base properties
     */
	public var textOptions: TextBaseOptions?
	
    /**
     Options Constructor
     */
	public init(identifier: String? = nil, classType: UILabel.Type = UILabel.self, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.textOptions = textOptions
	}
	
    /**
     CSS Constructor
     */
	public init(identifier: String? = nil, classType: UILabel.Type = UILabel.self, text: String? = nil, styleId: String? = nil, styleClass: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleId: styleId, styleClass: styleClass)
		self.textOptions = TextBaseOptions(text: text)
	}
}

//MARK: - Button options

///Structure for UIButton options
public struct ButtonOptions: ElementOptions {
	
    /**
     Generic structure that hold base properties
     */
	public var baseOptions: BaseOptions<UIButton>
    /**
     Structure for UIView base properties
     */
	public var viewBaseOptions: ViewBaseOptions?
    /**
     Structure for UI elements that support UILabel base properties
     */
	public var textOptionsForType: [LazyControlState: TextBaseOptions]?
    /**
     Structure for UI elements that support UIImageView base properties
     */
	public var imageOptionsForType: [LazyControlState: ImageBaseOptions]?
    /**
     The button type. See UIButtonType for the possible values.
     */
	public var type: UIButtonType
	
    /**
     Options Constructor
     */
	public init(identifier: String? = nil, classType: UIButton.Type = UIButton.self, type: UIButtonType = .custom, viewBaseOptions: ViewBaseOptions? = nil, textOptionsForType: [LazyControlState: TextBaseOptions]? = nil, imageOptionsForType: [LazyControlState: ImageBaseOptions]? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.textOptionsForType = textOptionsForType
		self.imageOptionsForType = imageOptionsForType
		self.type = type
	}
	
    /**
     CSS Constructor
     */
	public init(identifier: String? = nil, classType: UIButton.Type = UIButton.self, type: UIButtonType = .custom, texts: [LazyControlState: String]? = nil, styleId: String? = nil, styleClass: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleId: styleId, styleClass: styleClass)
		
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

///Structure for UIImageView options
public struct ImageOptions: ElementOptions {
	
    /**
     Generic structure that hold base properties
     */
	public var baseOptions: BaseOptions<UIImageView>
    /**
     Structure for UIView base properties
     */
	public var viewBaseOptions: ViewBaseOptions?
    /**
     Structure for UI elements that support UIImageView base properties
     */
	public var imageBaseOptions: ImageBaseOptions?
	
    /**
     Options Constructor
     */
	public init(identifier: String? = nil, classType: UIImageView.Type = UIImageView.self, viewBaseOptions: ViewBaseOptions? = nil, imageBaseOptions: ImageBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.imageBaseOptions = imageBaseOptions
	}
	
    /**
     CSS Constructor
     */
	public init(identifier: String? = nil, classType: UIImageView.Type = UIImageView.self, styleId: String? = nil, styleClass: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleId: styleId, styleClass: styleClass)
	}
}

//MARK: - TextField options

///Structure for UITextField options
public struct TextFieldOptions: ElementOptions {
	
    /**
     Generic structure that hold base properties
     */
	public var baseOptions: BaseOptions<UITextField>
    /**
     Structure for UIView base properties
     */
	public var viewBaseOptions: ViewBaseOptions?
    /**
     Structure for UI elements that support UILabel base properties
     */
	public var textOptions: TextBaseOptions?
    /**
     Structure for UI elements that support UILabel base properties
     */
	public var placeholderOptions: TextBaseOptions?
    /**
     Structure for UI elements that support Text inputs
     */
	public var textInputOptions: TextInputBaseOptions?
    /**
     The type of border drawn around the text field.
     */
	public var borderStyle: UITextBorderStyle?
	
    /**
     Options Constructor
     */
	public init(identifier: String? = nil, classType: UITextField.Type = UITextField.self, borderStyle: UITextBorderStyle? = nil, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil, placeholderOptions: TextBaseOptions? = nil, textInputOptions: TextInputBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.textOptions = textOptions
		self.borderStyle = borderStyle
		self.placeholderOptions = placeholderOptions
		self.textInputOptions = textInputOptions
	}
	
    /**
     CSS Constructor
     */
	public init(identifier: String? = nil, classType: UITextField.Type = UITextField.self, borderStyle: UITextBorderStyle? = nil, text: String? = nil, placeholderText: String? = nil, styleId: String? = nil, styleClass: String? = nil, textInputOptions: TextInputBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleId: styleId, styleClass: styleClass)
		self.borderStyle = borderStyle
		self.textOptions = TextBaseOptions(text: text)
		self.placeholderOptions = TextBaseOptions(text: placeholderText)
		self.textInputOptions = textInputOptions
	}
}

//MARK: - TextView options

///Structure for UITextView options
public struct TextViewOptions: ElementOptions {
	
    /**
     Generic structure that hold base properties
     */
	public var baseOptions: BaseOptions<UITextView>
    /**
     Structure for UIView base properties
     */
	public var viewBaseOptions: ViewBaseOptions?
    /**
     Structure for UI elements that support UILabel base properties
     */
	public var textOptions: TextBaseOptions?
    /**
     Structure for UI elements that support Text inputs
     */
	public var textInputOptions: TextInputBaseOptions?
	
    /**
     Options Constructor
     */
	public init(identifier: String? = nil, classType: UITextView.Type = UITextView.self, viewBaseOptions: ViewBaseOptions? = nil, textOptions: TextBaseOptions? = nil, textInputOptions: TextInputBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.textOptions = textOptions
		self.textInputOptions = textInputOptions
	}
	
    /**
     CSS Constructor
     */
	public init(identifier: String? = nil, classType: UITextView.Type = UITextView.self, text: String? = nil, styleId: String? = nil, styleClass: String? = nil, textInputOptions: TextInputBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleId: styleId, styleClass: styleClass)
		self.textOptions = TextBaseOptions(text: text)
		self.textInputOptions = textInputOptions
	}
}

//MARK: - TableView options

///Structure for UITableView options
public struct TableViewOptions: ElementOptions {
	
    /**
     Generic structure that hold base properties
     */
	public var baseOptions: BaseOptions<UITableView>
    /**
     Structure for UIView base properties
     */
	public var viewBaseOptions: ViewBaseOptions?
    /**
     The style of the table view.
     */
	public var style: UITableViewStyle = .plain
	/**
	The style for cells used as separators.
	*/
	public var cellSeparatorStyle: UITableViewCellSeparatorStyle = .singleLine
	
    /**
     Options Constructor
     */
	public init(identifier: String? = nil, classType: UITableView.Type = UITableView.self, style: UITableViewStyle = .plain, cellSeparatorStyle: UITableViewCellSeparatorStyle = .singleLine, viewBaseOptions: ViewBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.style = style
		self.cellSeparatorStyle = cellSeparatorStyle
	}
	
    /**
     CSS Constructor
     */
	public init(identifier: String? = nil, classType: UITableView.Type = UITableView.self, style: UITableViewStyle = .plain, styleId: String? = nil, styleClass: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleId: styleId, styleClass: styleClass)
		self.style = style
	}
}

//MARK: - TableView options

///Structure for UICollectionView options
public struct CollectionViewOptions: ElementOptions {
	
    /**
     Generic structure that hold base properties
     */
	public var baseOptions: BaseOptions<UICollectionView>
    /**
     Structure for UIView base properties
     */
	public var viewBaseOptions: ViewBaseOptions?
    /**
     The layout class type to use for organizing items.
    */
	public var collectionViewLayoutType = UICollectionViewLayout.self
	
    /**
     Options Constructor
     */
	public init(identifier: String? = nil, classType: UICollectionView.Type = UICollectionView.self, collectionViewLayoutType: UICollectionViewLayout.Type = UICollectionViewLayout.self, viewBaseOptions: ViewBaseOptions? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType)
		self.viewBaseOptions = viewBaseOptions
		self.collectionViewLayoutType = collectionViewLayoutType
	}
	
    /**
     CSS Constructor
     */
	public init(identifier: String? = nil, classType: UICollectionView.Type = UICollectionView.self, collectionViewLayoutType: UICollectionViewLayout.Type = UICollectionViewLayout.self, styleId: String? = nil, styleClass: String? = nil) {
		
		self.baseOptions = BaseOptions(identifier: identifier, classType: classType, styleId: styleId, styleClass: styleClass)
		self.collectionViewLayoutType = collectionViewLayoutType
	}
}
