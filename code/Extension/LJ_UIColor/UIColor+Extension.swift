//
//  UIColor+Extension.swift
//  code
//
//  Created by zhishen－mac on 2018/11/28.
//  Copyright © 2018 zhishen－mac. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    ///返回随机颜色
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    class var colorAccent: UIColor{
        get {
            return UIColor.colorWithHexString(color: "49b4fe")
        }
    }
    class var colortext1: UIColor{
        get {
            return UIColor.colorWithHexString(color: "333333")
        }
    }
    class var colortext2: UIColor{
        get {
            return UIColor.colorWithHexString(color: "666666")
        }
    }
    
    class func colorWithHexColorString(_ color: String) -> UIColor {
        
        return UIColor.colorWithHexString(color: color)
        
    }
    /// 十六进制颜色
    ///
    /// - Parameters:
    ///   - color: 颜色的十六进制字符
    ///   - alpha: 透明度，不传默认为 1
    /// - Returns: color
    class func colorWithHexString(color: String, alpha: CGFloat? = 1.0) -> UIColor {
        var cSting = color.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString
        if cSting.length < 6 {
            return UIColor.clear
        }
        if cSting.hasPrefix("0x") {
            cSting = cSting.substring(from: 2) as NSString
        }
        if cSting.hasPrefix("0X") {
            cSting = cSting.substring(from: 2) as NSString
        }
        if cSting.hasPrefix("#") {
            cSting = cSting.substring(from: 1) as NSString
        }
        if cSting.length != 6 {
            return UIColor.clear
        }
        var range = NSRange.init()
        range.length = 2
        // R
        range.location = 0
        let rStr = cSting.substring(with: range)
        // G
        range.location = 2
        let gStr = cSting.substring(with: range)
        // B
        range.location = 4
        let bStr = cSting.substring(with: range)
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rStr).scanHexInt32(&r)
        Scanner.init(string: gStr).scanHexInt32(&g)
        Scanner.init(string: bStr).scanHexInt32(&b)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha!)
    }
}
