//
//  NSDateExtension.swift
//  LazyKit
//
//  Created by Kevin Malkic on 04/02/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

internal extension Date {
	
	static internal func logTimeStamp() -> String {
		
		let formatter = DateFormatter()
		formatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.dateFormat = "(HH:mm:ss.SSS) "
		return formatter.string(from: Date())
	}
}
