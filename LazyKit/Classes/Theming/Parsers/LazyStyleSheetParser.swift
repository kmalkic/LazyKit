//
//  LazyStyleSheetParser.swift
//  LazyKit
//
//  Created by Malkic Kevin on 20/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

internal protocol LazyStyleSheetParser {
    
    weak var delegate:LazyStyleSheetParserDelegate? { get set }
    
    func parseSource(_ sourcePath:String?, delegate:LazyStyleSheetParserDelegate?)
    
    func parseData(_ fileData:Data?, delegate:LazyStyleSheetParserDelegate?)
    
    func parseContentString(_ contentString:String?, delegate:LazyStyleSheetParserDelegate?)
    
}

internal protocol LazyStyleSheetParserDelegate : NSObjectProtocol {
    
    func didFinishParsing(_ parser: LazyStyleSheetParser, styleSets: Array<LazyStyleSet>!)
    
    func didFailParsing(_ parser: LazyStyleSheetParser, error: NSError)
    
}
