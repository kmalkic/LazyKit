//
//  NSDateExtension.swift
//  LazyKit
//
//  Created by Kevin Malkic on 04/02/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

internal extension NSDate {
	
	static internal func logTimeStamp() -> String {
		
		let formatter = NSDateFormatter()
		formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
		formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
		formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
		formatter.dateFormat = "(HH:mm:ss.SSS) "
		return formatter.stringFromDate(NSDate())
	}
}
