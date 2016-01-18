//
//  LazyStyleSheetParser.swift
//  LazyKit
//
//  Created by Malkic Kevin on 20/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

protocol LazyStyleSheetParser {
    
    weak var delegate:LazyStyleSheetParserDelegate? { get set }
    
    func parseSource(sourcePath:String?, delegate:LazyStyleSheetParserDelegate?)
    
    func parseData(fileData:NSData?, delegate:LazyStyleSheetParserDelegate?)
    
    func parseContentString(contentString:String?, delegate:LazyStyleSheetParserDelegate?)
    
}

protocol LazyStyleSheetParserDelegate : NSObjectProtocol {
    
    func didFinishParsing(parser: LazyStyleSheetParser, styleSets: Array<LazyStyleSet>!)
    
    func didFailParsing(parser: LazyStyleSheetParser, error: NSError)
    
}