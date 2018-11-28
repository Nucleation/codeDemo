//
//  NIbAndSB+Extension.swift
//  code
//
//  Created by zhishen－mac on 2018/11/28.
//  Copyright © 2018 zhishen－mac. All rights reserved.
//

import Foundation
import UIKit
@objc protocol NibLoadable {}

extension NibLoadable {
    static func loadViewFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
    }
}
@objc protocol StoryboardLoadable {}
extension StoryboardLoadable where Self: UIViewController {
    /// 提供 加载方法
    static func loadStoryboard() -> Self {
        return UIStoryboard(name: "\(self)", bundle: nil).instantiateViewController(withIdentifier: "\(self)") as! Self
    }
    ///根据SB名称加载
    static func loadStoryboard(name:String) -> Self {
        print(self)
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}
