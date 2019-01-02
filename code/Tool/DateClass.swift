//
//  DateClass.swift
//  code
//
//  Created by zhishen－mac on 2019/1/2.
//  Copyright © 2019 zhishen－mac. All rights reserved.
//

import UIKit

class DateClass {
    //获取系统的当前时间戳
    static func getStamp()->Int{
        //获取当前时间戳
        let date = Date()
        let timeInterval:Int = Int(date.timeIntervalSince1970)
        return timeInterval
    }
    
    //获取系统的当前时间戳字符串
    static func getStringStamp()->String{
        //获取当前时间戳
        let date = Date()
        let timeInterval:Int = Int(date.timeIntervalSince1970)
        return "\(timeInterval)"
    }
    
    //将时间戳字符串转换为fmatter("yyyy-MM-dd  HH:mm:ss")
    static func timeStampToString(_ timeStamp:String ,fmatter:String)->String {
        let string = NSString(string: String(timeStamp.substring(toIndex: 10)))
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = fmatter
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    //将时间转换为时间戳
    static func stringToTimeStamp(_ stringTime:String)->Int {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dfmatter.locale = Locale.current
        let date = dfmatter.date(from: stringTime)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        return dateSt
    }
}
