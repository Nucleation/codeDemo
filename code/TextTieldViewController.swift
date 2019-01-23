//
//  TextTieldViewController.swift
//  code
//
//  Created by zhishen－mac on 2019/1/21.
//  Copyright © 2019 zhishen－mac. All rights reserved.
//

import UIKit

/// txteField字数限制
class TextTieldViewController: UIViewController,UITextFieldDelegate {
    lazy var textField:UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 100, width: 100, height: 50))
        textField.placeholder = "11111"
        textField.delegate = self
        self.view.addSubview(textField)
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //监听textField内容改变通知
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.greetingTextFieldChanged),
                                               name:NSNotification.Name(rawValue:"UITextFieldTextDidChangeNotification"),
                                               object: self.textField)
    }
    
    //textField内容改变通知响应
    @objc func greetingTextFieldChanged(obj: Notification) {
        //非markedText才继续往下处理
        guard let _: UITextRange = textField.markedTextRange else{
            //当前光标的位置（后面会对其做修改）
            let cursorPostion = textField.offset(from: (textField.endOfDocument),
                                                 to: (textField.selectedTextRange!.end))
            //判断非中文的正则表达式
            let pattern = "[^\\u4E00-\\u9FA5]"
//            非中文：[^\\u4E00-\\u9FA5]
//            非英文：[^A-Za-z]
//            非数字：[^0-9]
//            非中文或英文：[^A-Za-z\\u4E00-\\u9FA5]
//            非英文或数字：[^A-Za-z0-9]
//            非因为或数字或下划线：[^A-Za-z0-9_]
            //替换后的字符串（过滤调非中文字符）
            var str = textField.text?.pregReplace(pattern: pattern, with: "")
            textField.text = str
            if str?.count ?? 0 > 10 {
                str = String(str?.prefix(10) ?? "")
            }
            //让光标停留在正确位置
            let targetPostion = textField.position(from: textField.endOfDocument,
                                                   offset: cursorPostion)!
            textField.selectedTextRange = textField.textRange(from: targetPostion,
                                                              to: targetPostion)
            return
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //移除textField内容改变通知监听
        NotificationCenter.default.removeObserver(self,
                                                  name:NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"),
                                                  object: self.textField)
    }
}
