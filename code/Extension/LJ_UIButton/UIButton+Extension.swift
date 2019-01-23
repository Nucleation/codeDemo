//
//  UIButton+Extension.swift
//  code
//
//  Created by zhishen－mac on 2018/11/28.
//  Copyright © 2018 zhishen－mac. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func title(title:String,font:CGFloat,backColor:UIColor,titleColor:UIColor) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: font)
        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
        //        self.contentHorizontalAlignment = .left
    }
    
    //UIButton中的字 居中 居左  居右
    func titleAligment(aligment:Int)  { //0居中。 1居左 2居右
        if aligment == 0 {
            self.contentHorizontalAlignment = .center
        } else if aligment == 1 {
            self.contentHorizontalAlignment = .left
        } else {
            self.contentHorizontalAlignment = .right
        }
    }
    
    func layerRadius(Color:UIColor,radius:CGFloat,width:CGFloat)  {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderWidth = width
        self.layer.borderColor = Color.cgColor
    }
    // MARK: - 倒计时
    public func countDown(count: Int){
        // 倒计时开始,禁止点击事件
        isEnabled = false 
        // 保存当前的背景颜色
        let defaultColor = self.backgroundColor
        // 设置倒计时,按钮背景颜色
        backgroundColor = UIColor.gray
        var remainingCount: Int = count {
            willSet {
                setTitle("重新发送(\(newValue))", for: .normal)
                
                if newValue <= 0 {
                    setTitle("发送验证码", for: .normal)
                }
            }
        }
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        codeTimer.setEventHandler(handler: {
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                // 每秒计时一次
                remainingCount -= 1
                // 时间到了取消时间源
                if remainingCount <= 0 {
                    self.backgroundColor = defaultColor
                    self.isEnabled = true
                    codeTimer.cancel()
                }
            }
        })
        // 启动时间源
        codeTimer.resume()
    }
    
    
}
