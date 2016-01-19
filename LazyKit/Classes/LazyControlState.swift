//
//  LazyControlState.swift
//  LazyKit
//
//  Created by Kevin Malkic on 15/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit

//This is because UIControleState was not Hashable, and making "extension LazyControlState : Hashable {" caused an invalid linkage type error while compiling in release

public struct LazyControlState : OptionSetType {
    
    private var value: UInt = 0
    init(_ value: UInt) { self.value = value }
    // MARK: _RawOptionSetType
    public init(rawValue value: UInt) { self.value = value }
    // MARK: NilLiteralConvertible
    init(nilLiteral: ()) { self.value = 0 }
    // MARK: RawRepresentable
    public var rawValue: UInt { return self.value }
    // MARK: BitwiseOperationsType
    
    public static var Normal: LazyControlState { return self.init(0) }
    public static var Highlighted: LazyControlState { return self.init(1 << 0) }
    public static var Disabled: LazyControlState { return self.init(1 << 1) }
    public static var Selected: LazyControlState { return self.init(1 << 2) }
    
    public var toUiControlState: UIControlState {
        
        switch self.value {
            
        case 0:
            return .Normal
        case 1 << 0:
            return .Highlighted
        case 1 << 1:
            return .Disabled
        case 1 << 2:
            return .Selected
        default:
            break
        }
        
        return UIControlState(rawValue: self.value)
    }
}

extension LazyControlState : Hashable {
    
    public var hashValue: Int {
        
        return Int(rawValue)
    }
}
