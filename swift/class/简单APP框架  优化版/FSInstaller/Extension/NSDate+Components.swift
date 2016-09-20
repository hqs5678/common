//
//  UITextFielExtension_Extension.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//


import UIKit

extension NSDate{
    
    
    public func components() -> NSDateComponents {
        let c = NSCalendar(calendarIdentifier: NSCalendarIdentifierRepublicOfChina)
        let comp =  c!.components([.Year, .Month, .Day, .Weekday, .Hour, .Minute, .Second], fromDate: self)
        
        return comp
    }
    
    public var year: Int {
        return Int(yearString())!
    }
    
    public var month: Int {
        return Int(monthString())!
    }
    
    public var day: Int {
        return Int(dayString())!
    }
    
    public func yearString() -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter.stringFromDate(self)
    }
    
    public func monthString() -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM"
        
        return dateFormatter.stringFromDate(self)
    }
    
    public func dayString() -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        
        return dateFormatter.stringFromDate(self)
    }
    
    // 返回某个月的天数
    public static func dateSizeOfMonth(mon: Int, year: Int) -> Int{
        let size = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        if mon == 2 {
            if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 {
                // 闰年
                return 29
            }
            else {
                return 28
            }
        }
        return size[mon - 1]
    }
    
    
   
}
