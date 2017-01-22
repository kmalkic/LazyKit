//
//  LazyControlState.swift
//  LazyKit
//
//  Created by Kevin Malkic on 15/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

///This is because UIControleState was not Hashable, and making "extension LazyControlState : Hashable {" caused an invalid linkage type error while compiling in release
public struct LazyControlState : OptionSet {
    
    fileprivate var value: UInt = 0
    
    init(_ value: UInt) { self.value = value }
    /** 
     _RawOptionSetType
     */
    public init(rawValue value: UInt) { self.value = value }
    /**
     NilLiteralConvertible
     */
    init(nilLiteral: ()) { self.value = 0 }
    /**
     RawRepresentable
     */
    public var rawValue: UInt { return self.value }

    /**
    Used when UIControl is normal
    */
    public static var Normal: LazyControlState { return self.init(0) }
    /**
     Used when UIControl isHighlighted is set
     */
    public static var Highlighted: LazyControlState { return self.init(1 << 0) }
    /**
     Used when UIControl is disabled
     */
    public static var Disabled: LazyControlState { return self.init(1 << 1) }
    /**
     Used when UIControl is selected
     */
    public static var Selected: LazyControlState { return self.init(1 << 2) }
    
    /**
     Converts LazyControlState to UIControlState
     */
    public var toUiControlState: UIControlState {
        
        switch self.value {
            
        case 0:
            return UIControlState()
        case 1 << 0:
            return .highlighted
        case 1 << 1:
            return .disabled
        case 1 << 2:
            return .selected
        default:
            break
        }
        
        return UIControlState(rawValue: self.value)
    }
}

extension LazyControlState : Hashable {
    
    /**
     Hashable
     */
    public var hashValue: Int {
        
        return Int(rawValue)
    }
}
