//
//  Base_Config.swift
//  LJNavigation
//
//  Created by zhishen－mac on 2019/1/17.
//  Copyright © 2019 zhishen－mac. All rights reserved.
//

import Foundation
import UIKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

/** **** 项目navi和tab配置 *** */
let isIphoneX_XS = kScreenWidth == 375 && kScreenHeight == 812 ? true : false
let isIphoneXR_XSMax = kScreenWidth == 414 && kScreenHeight == 896 ? true : false
let isFullScreen = isIphoneX_XS || isIphoneXR_XSMax
let statusBar_height: CGFloat = isFullScreen ? 44 : 20
let navi_height: CGFloat = statusBar_height + 44
let tabbar_height: CGFloat = isFullScreen ? (49+34) : 49
let TabbarSafeBottomMargin: CGFloat = isFullScreen ? 34 : 0

let REGEX_PHONE = "0?(13|14|15|17|18|19)[0-9]{9}"
let REGEX_URL = "^((https|http|ftp|rtsp|mms)?:\\/\\/)[^s]+"
let REGEX_EMAIL = "\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+.)+[A-Za-z]{2,14}"
let REGEX_CHINESE = "[\\u4e00-\\u9fa5]"
