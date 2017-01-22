//
//  LazyStyleSheetManager.swift
//  LazyKit
//
//  Created by Malkic Kevin on 23/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

/// Default collection name
public let kLazyDefaultCollectionName = "Default"
/// Notifies observers that an update session will start.
public let kUpdateStylesNotificationKey = "kUpdateStylesNotificationKey"

internal func registerUpdateStylesNotification(_ object: NSObject) {
	
	NotificationCenter.default.addObserver(object, selector: "didReceiveUpdateNotification", name: NSNotification.Name(rawValue: kUpdateStylesNotificationKey), object: nil)
}

internal func unregisterUpdateStylesNotification(_ object: NSObject) {
	
	NotificationCenter.default.removeObserver(object, name: NSNotification.Name(rawValue: kUpdateStylesNotificationKey), object: nil)
}

/// Style manager that handle collection of styles.
open class LazyStyleSheetManager: NSObject {
       
    internal var styleCollections = [String: LazyStyleSheet]()

    internal var styleCollectionsUrl = [String: [URL]]()
    
    internal var styleCollectionsNames = [String]()
    
    internal var enableThemeSwapping = false
    
    internal var displayStyleLabels = false {
        
        didSet {
            
            self.postUpdateStylesNotification()
        }
    }
    
    /**
        Current collection name.
    
        If not set it will be assigned the default value : kLazyDefaultCollectionName.
        On didSet it post a notification to all views to update their styles.
    
        You can call postUpdateStylesNotification() manually to trigger the same update.
    */
    open var currentCollectionName = kLazyDefaultCollectionName {
        
        didSet {
            
            postUpdateStylesNotification()
        }
    }
    
    //MARK: - Constructor
    
    /**
        Returns the singleton manager instance.
    
        - returns: The manager instance. It is created on the first call.
    */
    open static let shared = LazyStyleSheetManager()
    
    override init() {

    }

    
    //MARK: - internal
    
    internal func stylingForView(_ view: UIView, styleId: String? = nil, styleClass: String? = nil) -> LazyStyleSet? {
        
        if let styleSheet = styleCollections[currentCollectionName] {
            
            if let styleSet = styleSheet.styleThatMatchView(view, styleId: styleId, styleClass: styleClass) {
            
                return styleSet
            }
        }
        
        return nil
    }
    
    //MARK: - private
    
    fileprivate func keyText(_ key: String) -> String {
        return "  '" + key + "' "
    }
    
    fileprivate func usageText() -> String {
        return "\n     Usage: "
    }
    
    fileprivate func patternsText() -> String {
        return "\n     Patterns: "
    }
    
    fileprivate func setUrlToRefreshCollectionFile(_ collectionName: String, urls:[URL]) {
        
        if urls.count == 0 {
            
            return
        }
        
        styleCollectionsUrl[collectionName]! = urls
    }
    
    fileprivate func appendUrlToRefreshCollectionFile(_ collectionName: String, urls:[URL]) {
        
        if urls.count == 0 {
            
            return
        }
        
        if styleCollectionsUrl[collectionName] == nil {
            
            styleCollectionsUrl[collectionName] = [URL]()
        }
        
        styleCollectionsUrl[collectionName]! += urls
    }
    
    //MARK: - public
    
    /**
        Call postUpdateStylesNotification() manually to trigger all the views to update their styles.
    */
    open func postUpdateStylesNotification() {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: kUpdateStylesNotificationKey), object: nil)
    }
    
    /**
        For unnecessary use of internal functions, if you do not need to change any style on runtime set it to false.
        By default it is false.
    
        - parameter swapping: defines if the manager can handle swapping the current collection with another collection styles.
    */
    open func enableThemeSwapping(_ swapping: Bool) {
        
        enableThemeSwapping = swapping
    }

    /**
     Convenient function to set the main collection styles of the app under the kLazyDefaultCollectionName key.
     Note.: this will set a single file for the default collection.
     
     - parameter url: the url of the file.
     */
    open func setDefaultStylesFromFileAtUrl(_ url: URL?) -> Bool {
        
        return setStylesFromFileAtUrl(url, collectionName: kLazyDefaultCollectionName)
    }
    
    /**
     Convenient function to set the main collection styles of the app under the kLazyDefaultCollectionName key.
     
     - parameter urls: set of urls of all files required.
     */
    open func setDefaultStylesFromFileAtUrls(_ urls: [URL]) -> Bool {
    
        return setStylesFromFileAtUrls(urls, collectionName: kLazyDefaultCollectionName)
    }
    
    /**
     Function to set a different collection styles for the app using specific identifier key.
     Can be swapped at any time by changing currentCollectionName. (this will post a notification under kUpdateStylesNotificationKey)
     Note: you will have to manually update your UI elements, or set your configurations to conform to LazyViewConfigurationsOptions and use shouldRecreateAllElementsForThemeSwapping().
     
     - parameter url: the url of the file.
     - parameter collectionName: should specify an unique collection name.
     */
    open func setStylesFromFileAtUrl(_ url: URL?, collectionName: String) -> Bool {
        
        if url == nil {
            
            return false
        }
        
        return setStylesFromFileAtUrls([url!], collectionName: collectionName)
    }
    
    /**
     Function to set some differents collection styles for the app using specific identifier key.
     Can be swapped at any time by changing currentCollectionName. (this will post a notification under kUpdateStylesNotificationKey)
     Note: you will have to manually update your UI elements, or set your configurations to conform to LazyViewConfigurationsOptions and use shouldRecreateAllElementsForThemeSwapping().
     
     - parameter urls: set of urls of all files required.
     - parameter collectionName: should specify an unique collection name.
     */
    open func setStylesFromFileAtUrls(_ urls: [URL], collectionName: String) -> Bool {
        
        let styleSheet:LazyStyleSheet? = styleCollections[collectionName]
        
        if styleSheet != nil {
            
            styleCollections.removeValue(forKey: collectionName)
        }
        
        styleCollectionsUrl[collectionName] = [URL]()
        
        return appendStylesFromFileAtUrls(urls, collectionName: collectionName)
    }
    
    /**
     Function to append some differents collection styles for a specific collection name.
     
     - parameter urls: set of urls of all files required.
     - parameter collectionName: should specify an unique collection name.
     */
    open func appendStylesFromFileAtUrls(_ urls: [URL], collectionName: String) -> Bool {
        
        if urls.count == 0 {
            
            return false
        }
        
        appendUrlToRefreshCollectionFile(collectionName, urls: urls)
        
        var styleSheet:LazyStyleSheet? = styleCollections[collectionName]
        
        if styleSheet == nil {
            styleSheet = LazyStyleSheet()
            styleCollections[collectionName] = styleSheet!
        }
        
        if !styleCollectionsNames.contains(collectionName) {
            
            styleCollectionsNames.append(collectionName)
        }
        
        for url in urls {
            
            styleSheet!.startParsingFileAtUrl(url, parserType: .css)
        }
        
        return (styleSheet!.styleSets.count > 0)
    }
    
    /**
     Function to display some CSS available keys and usages.
     */
    open func help() {
        
        var helpText = "****************************** HELP ******************************\n"
        helpText +=    "******************** Available keys and usages *******************\n\n"
        
        helpText += "GENERAL KEYS:\n"
        helpText += keyText(kBackgroundKey) + "\n"
        helpText += keyText(kBackgroundColorKey) + "\n"
        helpText += keyText(kTintColorKey) + "\n"
        helpText += keyText(kBarTintColorKey) + ""
        helpText += usageText() + "#RBG | #ARGB | #RRGGBB | #AARRGGBB | rgb(red(0-255),green(0-255),blue(0-255)) | rgba(red(0-255),green(0-255),blue(0-255),alpha(0.0-1.0))\n"
        helpText += keyText(kBackgroundImageKey)
        helpText += usageText() + "image name, without \"\"\n"
        helpText += keyText(kBackgroundImageContentModeKey)
        helpText += usageText() + "scaleToFit | scaleToFill | center | top | left | bottom | right\n"
        
        helpText += "\n"
        
        helpText += "TEXT KEYS:\n"
        helpText += keyText(kTextColorKey)
        helpText += usageText() + "#RBG | #ARGB | #RRGGBB | #AARRGGBB | rgb(red(0-255),green(0-255),blue(0-255)) | rgba(red(0-255),green(0-255),blue(0-255),alpha(0.0-1.0))\n"
        helpText += keyText(kFontNameKey)
        helpText += usageText() + "font name, without \"\"\n"
        helpText += keyText(kFontSizeKey)
        helpText += usageText() + "size in px\n"
        helpText += keyText(kAlignmentSizeKey)
        helpText += usageText() + "left | center | right | justify\n"
        helpText += keyText(kNumberOfLinesKey)
        helpText += usageText() + "number of lines max (integer)\n"
        helpText += keyText(kLineSpacingKey)
        helpText += usageText() + "height in px\n"
        helpText += keyText(kParagraphSpacingKey)
        helpText += usageText() + "spacing in px\n"
        helpText += keyText(kHeadIndentKey)
        helpText += usageText() + "header in px. Used to indent first line of any new paragraph.\n"
        helpText += keyText(kWordWrapKey)
        helpText += usageText() + "word-wrapping | char-wrapping | clipping | truncating-head | truncating-tail | truncating-middle\n"
        helpText += keyText(kTextStrokeColorKey)
        helpText += usageText() + "#RBG | #ARGB | #RRGGBB | #AARRGGBB | rgb(red(0-255),green(0-255),blue(0-255)) | rgba(red(0-255),green(0-255),blue(0-255),alpha(0.0-1.0))\n"
        helpText += keyText(kTextStrokeWidthKey)
        helpText += usageText() + "width in px\n"
        helpText += keyText(kTextDecorationKey)
        helpText += usageText() + "none|underline|line-through\n"
        helpText += keyText(kTextDecorationColorKey)
        helpText += usageText() + "#RBG | #ARGB | #RRGGBB | #AARRGGBB | rgb(red(0-255),green(0-255),blue(0-255)) | rgba(red(0-255),green(0-255),blue(0-255),alpha(0.0-1.0))\n"
        
        helpText += "\nFor placeholder styling\n"
        helpText += keyText(TextSearchMode.Placeholder.rawValue)
        helpText += usageText() + "You can add '" + TextSearchMode.Placeholder.rawValue + "' to any of the above text keys\n"
        
        helpText += "\n"
        
        helpText += "DECORATIONS KEYS:\n"
        helpText += keyText(kBorderKey)
        helpText += patternsText() + "\n"
        helpText += "       - width color\n"
//        helpText += "       - vertical-width horizontal-width color\n"
//        helpText += "       - top-width left-width bottom-width right-width color\n"
        
        helpText += keyText(kBorderColorKey)
        helpText += usageText() + "#RBG | #ARGB | #RRGGBB | #AARRGGBB | rgb(red(0-255),green(0-255),blue(0-255)) | rgba(red(0-255),green(0-255),blue(0-255),alpha(0.0-1.0))\n"
        
        helpText += keyText(kBorderWidthKey)
        helpText += patternsText() + "\n"
        helpText += "       - width\n"
//        helpText += "       - vertical-width horizontal-width\n"
//        helpText += "       - top-width left-width bottom-width right-width\n"
        
        helpText += keyText(kBorderRadiusKey)
        helpText += usageText() + "radius in px\n"
        
        helpText += "\n"
//
//        helpText += "OPTIONS KEYS:\n"
//        helpText += keyText(kBar_TranslucentKey)
//        helpText += usageText() + "true | false\n\n"
        
        helpText += "******************************************************************\n\n"
        
        print(helpText)
    }

}
