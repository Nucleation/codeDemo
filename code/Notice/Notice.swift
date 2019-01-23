//
//  Notice.swift
//  code
//
//  Created by zhishen－mac on 2019/1/23.
//  Copyright © 2019 zhishen－mac. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func noticeText(text:String,fontSize:CGFloat,obliqueness:NSNumber?) {
        Notice.showText(text: text, fontSize: fontSize, obliqueness: obliqueness ?? 0)
    }
}
class Notice: NSObject {
    static var windows = [UIWindow]()
    static let rv: UIView = UIApplication.shared.keyWindow?.subviews.first ?? UIView()
    static func clear(){
        windows.removeAll(keepingCapacity: false)
    }
    static func showText(text:String,fontSize:CGFloat,obliqueness:NSNumber){
        let frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        let window = UIWindow(frame: frame)
        let mainView = UIView(frame: frame)
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        let label = UILabel(frame: frame)
        label.text = text
        if obliqueness == 0{
            label.font = UIFont.systemFont(ofSize: fontSize)
        }else if obliqueness == 1{
            label.font = UIFont(name: NSAttributedStringKey.obliqueness.rawValue, size: fontSize)
        }else if obliqueness == 2{
            label.font = UIFont.boldSystemFont(ofSize: fontSize)
        }
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        mainView.addSubview(label)
        
        window.windowLevel = UIWindowLevelAlert
        window.center = rv.center
        window.frame = CGRect(x: rv.center.x - frame.size.width/2, y: rv.center.y/3, width: frame.size.width, height: frame.size.height)
        window.isHidden  = false
        window.addSubview(mainView)
        windows.append(window)
        let selector = #selector(hideNotice(sender:))
        self.perform(selector, with: mainView, afterDelay: 1)
    }
    @objc static func hideNotice(sender: AnyObject){
        sender.removeFromSuperview()
        windows.removeAll(keepingCapacity: false)
    }
}
