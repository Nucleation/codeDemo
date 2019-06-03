//
//  KeyBoardHeight.swift
//  code
//
//  Created by zhishen－mac on 2019/1/24.
//  Copyright © 2019 zhishen－mac. All rights reserved.
//

import Foundation
import UIKit

var keyBoardKey = 1000
extension UIViewController{
    var keyBoardHeight: CGFloat{
        set{
            objc_setAssociatedObject(self, &keyBoardKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get{
            if let rs = objc_getAssociatedObject(self, &keyBoardKey) as? CGFloat{
                return rs
            }
            return 0
        }
    }
    func addKeyBoardObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    func removeKeyBoardObserver(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    @objc func keyBoardShow(notification:Notification){
        let userinfo: NSDictionary = notification.userInfo! as NSDictionary
        let nsValue = userinfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRec = nsValue.cgRectValue
        let height = keyboardRec.size.height
       self.keyBoardHeight = height
    }
    
}
