//
//  Date+Extension.swift
//  code
//
//  Created by zhishen－mac on 2018/11/28.
//  Copyright © 2018 zhishen－mac. All rights reserved.
//

import Foundation

extension Date {
    //MARK: - 获取日期各种值
    //MARK: 年
    func year() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.year!
    }
    //MARK: 月
    func month() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.month!
        
    }
    //MARK: 日
    func day() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.day!
        
    }
    //MARK: 星期几
    func weekDay()->Int{
        let interval = Int(self.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    //MARK: 当月天数
    func countOfDaysInMonth() ->Int {
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        return (range?.length)!
        
    }
    //MARK: 当月第一天是星期几
    func firstWeekDay() ->Int {
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let firstWeekDay = (calendar as NSCalendar?)?.ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: self)
        return firstWeekDay! - 1
        
    }
    //MARK: - 日期的一些比较
    //是否是今天
//    func isToday()->Bool {
//        let calendar = NSCalendar.current
//        let com = calendar.dateComponents([.year,.month,.day], from: self)
//        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
//        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
//    }
    //是否是这个月
    func isThisMonth()->Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month
    }
    static func formatTime(timeInterval:TimeInterval) -> String {
        let date = Date.init(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter.init()
        if date.isToday() {
            if date.isJustNow() {
                return "刚刚"
            } else {
                formatter.dateFormat = "HH:mm"
                return formatter.string(from: date)
            }
        } else {
            if date.isYestoday() {
                formatter.dateFormat = "昨天HH:mm"
                return formatter.string(from: date)
            } else if date.isCurrentWeek() {
                formatter.dateFormat = date.dateToWeekday() + "HH:mm"
                return formatter.string(from: date)
            } else {
                if date.isCurrentYear() {
                    formatter.dateFormat = "MM-dd  HH:mm"
                } else {
                    formatter.dateFormat = "yy-MM-dd  HH:mm"
                }
                return formatter.string(from: date)
            }
        }
    }
    
    func isJustNow() -> Bool {
        let now = Date.init().timeIntervalSince1970
        return fabs(now - self.timeIntervalSince1970) < 60 * 2 ? true : false
    }
    
    func isCurrentWeek() -> Bool {
        let nowDate = Date.init().dateFormatYMD()
        let selfDate = self.dateFormatYMD()
        let calendar = Calendar.current
        let cmps = calendar.dateComponents([.day], from: selfDate, to: nowDate)
        return cmps.day ?? 0 <= 7
    }
    
    func isCurrentYear() -> Bool {
        let calendar = Calendar.current
        let nowComponents = calendar.dateComponents([.year], from: Date.init())
        let selfComponents = calendar.dateComponents([.year], from: self)
        return selfComponents.year == nowComponents.year
    }
    
    func dateToWeekday() -> String {
        let weekdays = ["", "星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        var calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.dateComponents([.weekday], from: self)
        return weekdays[theComponents.weekday ?? 0]
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        let nowComponents = calendar.dateComponents([.day, .month, .year], from: Date.init())
        let selfComponents = calendar.dateComponents([.day, .month, .year], from: self)
        return nowComponents.year == selfComponents.year && nowComponents.month == selfComponents.month && nowComponents.day == selfComponents.day
    }
    
    func isYestoday() -> Bool {
        let nowDate = Date.init().dateFormatYMD()
        let selfDate = self.dateFormatYMD()
        let calendar = Calendar.current
        let cmps = calendar.dateComponents([.day], from: selfDate, to: nowDate)
        return cmps.day == 1
    }
    
    func dateFormatYMD() -> Date {
        let fmt = DateFormatter.init()
        fmt.dateFormat = "yyyy-MM-dd"
        let selfStr = fmt.string(from: self)
        return fmt.date(from: selfStr)!
    }
}
