//
//  LazyStyleSheetCSSParser.swift
//  LazyKit
//
//  Created by Malkic Kevin on 20/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

internal func matchesForRegexInText(_ regex: String!, text: String?) -> [String]? {
	
	guard let text = text else {
	
		return nil
	}
	
    do {
        let regex = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
        let nsString = text as NSString
        let results = regex.matches(in: text, options: .reportCompletion, range: NSMakeRange(0, nsString.length))
        return results.map({ nsString.substring(with: $0.range) })
        
    } catch {
        
        return nil
    }
}

internal class LazyStyleSheetCSSParser: LazyStyleSheetParser {
    
    weak var delegate:LazyStyleSheetParserDelegate?
    
    func parseSource(_ sourcePath:String?, delegate:LazyStyleSheetParserDelegate?) {
        
        parseContentString(sourcePath, delegate: delegate)
    }

    func parseData(_ fileData:Data?, delegate:LazyStyleSheetParserDelegate?) {
        
        guard let fileData = fileData else {
            
            delegate?.didFailParsing(self, error: NSError(domain: "Parsing error", code: 0, userInfo: ["reason" : "source is nil."]))
            return
        }
        
        let contentString = NSString(data: fileData,encoding: String.Encoding.utf8.rawValue) as! String
                
        parseContentString(contentString, delegate: delegate)
    }
    
    func parseContentString(_ contentString:String?, delegate:LazyStyleSheetParserDelegate?) {
        
        self.delegate = delegate
        
        guard let contentString = contentString else {
            
            delegate?.didFailParsing(self, error: NSError(domain: "Parsing error", code: 0, userInfo: ["reason" : "source is nil."]))
            return
        }
        
        guard let styleSets = parseContent(contentString as NSString?) else {
            
            delegate?.didFailParsing(self, error: NSError(domain: "Parsing error", code: 0, userInfo: ["reason" : "Something when wrong while parsing the source."]))
            return
        }
            
        delegate?.didFinishParsing(self, styleSets: styleSets)
    }
    
    fileprivate func cleanElementName(_ string:String?) -> String? {
        
        return string?.replacingOccurrences(of: "{", with: "").trimmingCharacters(in: .whitespaces)
    }
    
    fileprivate func cleanProperty(_ string:String?) -> String? {
        
        return string?.replacingOccurrences(of: ":", with: "").replacingOccurrences(of: ";", with: "").trimmingCharacters(in: .whitespaces)
    }
    
    fileprivate func parseContent(_ content: NSString?) -> Array<LazyStyleSet>? {
        
        let contentString = content as! String
        
        var variablesDict = [String: String]()
        
        if let variables = matchesForRegexInText("@(.*\\s*):\\s*(.*?);", text: contentString) {
            
            for variable in variables {
                
                var variableName = matchesForRegexInText("@(.*\\s*):", text: variable)?.first
                var variableValue = matchesForRegexInText(":\\s*(.*)\\s*;", text: variable)?.first
                
                variableValue = cleanProperty(variableValue)
                variableName = cleanProperty(variableName)
                
                if let variableName = variableName, let variableValue = variableValue {
                    
                    variablesDict[variableName] = variableValue
                }
            }
        }
        
        let newContentString = contentString.replacingOccurrences(of: "\n", with: "")
        
        var styleSets = [LazyStyleSet]();
        
        if let elements = matchesForRegexInText("(\\s*|(\\}\\s*))([a-zA-Z\\.\\-\\#\\_]*?)\\s*\\{\\s*(([.]*?)?[^}]+?)+\\s*\\}", text: newContentString) {
            
            for element in elements {
                
                var elementName = matchesForRegexInText("\\s*(.*?)\\s*\\{", text: element)?.first
                elementName = cleanElementName(elementName)
                
                let elementProperties = matchesForRegexInText("([^\\s]*?):\\s*(.*?);", text: element)
                
                let styleSet = LazyStyleSet(elementName: elementName, content: elementProperties, variables: variablesDict)
                
                if styleSet.basicSet != nil || styleSet.textSet != nil || styleSet.decorationSet != nil || styleSet.optionSet != nil {
                    
                    styleSets.append(styleSet)
                }
            }
        }
        
        return styleSets
    }
    
}
