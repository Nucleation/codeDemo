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
}
