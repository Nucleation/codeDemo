//
//  String+Extension.swift
//  code
//
//  Created by zhishen－mac on 2018/11/28.
//  Copyright © 2018 zhishen－mac. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var length:Int { return (self as NSString).length }
    
    var bool:Bool { return (self as NSString).boolValue }
    
    var integer:NSInteger { return (self as NSString).integerValue }
    
    var float:Float { return (self as NSString).floatValue }
    
    var cgFloat:CGFloat { return CGFloat(self.float) }
    
    var double:Double { return (self as NSString).doubleValue }
    
    /// 文件后缀(不带'.')
    var pathExtension:String { return (self as NSString).pathExtension }
    
    /// 文件名(带后缀)
    var lastPathComponent:String { return (self as NSString).lastPathComponent }
    
    /// 文件名(不带后缀)
    var deletingPathExtension:String { return (self as NSString).deletingPathExtension }
    
    /// 去除首尾空格
    var removeSpaceHeadAndTail:String { return trimmingCharacters(in: NSCharacterSet.whitespaces) }
    
    /// 去除首尾换行
    var removeEnterHeadAndTail:String { return trimmingCharacters(in: NSCharacterSet.whitespaces) }
    
    /// 去除首尾空格和换行
    var removeSpaceHeadAndTailPro:String { return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) }
    
    /// 去掉所有空格
    var removeSapceAll:String { return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "　", with: "") }
    
    /// 去掉逗号
    var removeComma:String {
        return replacingOccurrences(of: ",", with: " ").replacingOccurrences(of: ",", with: " ")
    }
    /// 去除所有空格换行
    var removeSapceEnterAll:String { return removeSapceAll.replacingOccurrences(of: "\n", with: "") }
    
    /// 是否为整数
    var isInt:Bool {
        
        let scan: Scanner = Scanner(string: self)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    /// 是否为数字或Float
    var isFloat:Bool {
        
        let scan: Scanner = Scanner(string: self)
        
        var val:Float = 0
        
        return scan.scanFloat(&val) && scan.isAtEnd
    }
    
    /// 是否为空格
    var isSpace:Bool {
        
        if (self == " ") || (self == "　") { return true }
        
        return false
    }
    
    /// 是否为空格或者回车
    var isSpaceOrEnter:Bool {
        
        if isSpace || (self == "\n") { return true }
        
        return false
    }
    
    /// 转JSON
    var json:Any? {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        return json
    }
    
    /// 是否包含字符串
    func range(_ string: String) ->NSRange {
        
        return (self as NSString).range(of: string)
    }
    
    /// 截取字符串
    func substring(_ range:NSRange) ->String {
        
        return (self as NSString).substring(with: range)
    }
    
    /// 处理带中文的字符串
    func addingPercentEncoding(_ characters: CharacterSet = .urlQueryAllowed) ->String {
        
        return (self as NSString).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    
    /// 正则替换字符
    func replacingCharacters(_ pattern:String, _ template:String) ->String {
        
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            
            return regularExpression.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, length), withTemplate: template)
            
        } catch {return self}
    }
    ///使用正则表达式替换
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    ///根据正则判断
    func isMatches(pattern:String) -> Bool {
        if isEmpty {return false}
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let resultNum = regularExpression.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.length))
            if resultNum > 0{
                return true
            }else{
                return false
            }
        } catch  {
            return false
        }
    }
    /// 正则搜索相关字符位置
    func matches(_ pattern:String) ->[NSTextCheckingResult] {
        
        if isEmpty {return []}
        
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            
            return regularExpression.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, length))
            
        } catch {return []}
    }
    
    /// 计算大小
    func size(_ font:UIFont, _ size:CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) ->CGSize {
        
        let string:NSString = self as NSString
        
        return string.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [.font:font], context: nil).size
    }
    ///bigDecimal转字符串
    func bigDecimalToString() -> String {
        let roundingBehavior = NSDecimalNumberHandler(roundingMode: .bankers, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        var ouncesDecimal: NSDecimalNumber?
        var roundedOunces: NSDecimalNumber?
        ouncesDecimal = NSDecimalNumber(string: self)
        roundedOunces = ouncesDecimal?.rounding(accordingToBehavior: roundingBehavior)
        return "\(roundedOunces ?? NSDecimalNumber())"
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    //不包含后几个字符串的方法
    func dropLast(_ n: Int = 1) -> String {
        return String(self.dropLast(n))
    }
    var dropLast: String {
        return dropLast()
    }
    //添加缩进
    func addHeadIndent(indent: CGFloat) -> NSMutableAttributedString{
        let attributedString = NSMutableAttributedString(string:self)
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = indent
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: self.count))
        return attributedString
    }
    //价格中间横线
    func priceString() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string:self)
        attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSNumber.init(value: 1), range: NSRange(location: 0, length: self.count))
        return attributedString
        
    }
    ///文本行间距
    func lineSpace(lineSapce:CGFloat) -> NSMutableAttributedString {
        let att = NSMutableAttributedString(string:self)
        let para = NSMutableParagraphStyle()
        para.lineSpacing = lineSapce
        att.addAttributes([NSAttributedStringKey.paragraphStyle:para], range: NSMakeRange(0, self.count))
        return att
    }
    
    
    //电话号码加*
    var phoneMash:String{
        get{
            return (self.enumerated().map { i,c -> String in
                if [3,4,5,6].contains(i)  {
                    return "*"
                }
                return c.description
            }).joined(separator: "")
        }
    }
    //身份证号码加*
    var idCardMash:String{
        get{
            return (self.enumerated().map { i,c -> String in
                if [0,17].contains(i)  {
                    
                }else{
                    return "*"
                }
                return c.description
            }).joined(separator: "")
        }
    }
    //获取下标对应的字符
    func charAt(pos: Int) -> Character? {
        if pos < 0 || pos >= count {
            return nil   //判断边界条件
        }
        let index = self.index(self.startIndex, offsetBy: pos)
        let str = self[index]
        return Character(String(str))
    }
    /// 描述KM字符串距离
    var distanceKM:String{
        get{
            let _distance = Double(self) ?? 0
            if _distance < 1{
                return " \(Int(_distance * 1000)) m "
            }else{
                return " \(Double(Int(_distance * 100) ) / 100) km "
            }
        }
    }
    /// 描述M字符串距离
    var distanceM:String{
        get{
            let _distance = Double(self) ?? 0
            if _distance < 1000{
                return " \(Int(_distance)) m "
            }else{
                return " \(Double(Int((_distance / 10) * 10) ) / 10) km "
            }
        }
    }
    ///字符串截取
    func substring(location index:Int, length:Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let endIndex = self.index(self.startIndex, offsetBy: index + length)
            let subString = self[startIndex..<endIndex]
            return String(subString)
        } else {
            return self
        }
    }
    
    func substring(range:NSRange) -> String {
        if self.count > range.location {
            let startIndex = self.index(self.startIndex, offsetBy: range.location)
            let endIndex = self.index(self.startIndex, offsetBy: range.location + range.length)
            let subString = self[startIndex..<endIndex]
            return String(subString)
        } else {
            return self
        }
    }
    ///MD5 需要导入MD5
//
//    func md5() -> String {
//        let cStrl = cString(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
//        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
//        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer);
//        var md5String = "";
//        for idx in 0...15 {
//            let obcStrl = String.init(format: "%02x", buffer[idx]);
//            md5String.append(obcStrl);
//        }
//        free(buffer);
//        return md5String;
//    }
    ///单行文本Size
    func singleLineSizeWithText(font:UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font : font])
    }
    
    func singleLineSizeWithAttributeText(font:UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font:font]
        let attString = NSAttributedString(string: self,attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, CGSize(width: Double.greatestFiniteMagnitude, height: Double.greatestFiniteMagnitude), nil)
    }
}
