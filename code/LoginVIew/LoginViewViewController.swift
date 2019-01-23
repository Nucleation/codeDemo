//
//  LoginViewViewController.swift
//  code
//
//  Created by zhishen－mac on 2019/1/21.
//  Copyright © 2019 zhishen－mac. All rights reserved.
//

import UIKit
enum LoginState: Int {
    case pwd = 0;
    case code
}
class LoginViewViewController: UIViewController {
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var pwdLab: UILabel!
    @IBOutlet weak var changeLoginBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var sendCode: UIButton!
    var loginState:LoginState  = .pwd
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLoginBtn.tag = LoginState.pwd.rawValue
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        //监听textField内容改变通知
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.greetingTextFieldChanged),
                                               name:NSNotification.Name(rawValue:"UITextFieldTextDidChangeNotification"),
                                               object: self.phoneTF)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.greetingTextFieldChanged),
                                               name:NSNotification.Name(rawValue:"UITextFieldTextDidChangeNotification"),
                                               object: self.pwdTF)
    }
    
    //textField内容改变通知响应
    @objc func greetingTextFieldChanged(obj: Notification) {
        //非markedText才继续往下处理
        if obj.object as? UITextField == self.phoneTF{
            guard let _: UITextRange = self.phoneTF.markedTextRange else{
                //当前光标的位置（后面会对其做修改）
                let cursorPostion = self.phoneTF.offset(from: (self.phoneTF.endOfDocument),
                                                        to: (self.phoneTF.selectedTextRange!.end))
                //判断非中文的正则表达式
                let pattern = "[^0-9]"
                //            非中文：[^\\u4E00-\\u9FA5]
                //            非英文：[^A-Za-z]
                //            非数字：[^0-9]
                //            非中文或英文：[^A-Za-z\\u4E00-\\u9FA5]
                //            非英文或数字：[^A-Za-z0-9]
                //            非因为或数字或下划线：[^A-Za-z0-9_]
                //替换后的字符串（过滤调非中文字符）
                var str = self.phoneTF.text?.pregReplace(pattern: pattern, with: "")
                if str?.count ?? 0 > 11 {
                    str = String(str?.prefix(11) ?? "")
                }
                self.phoneTF.text = str
                //让光标停留在正确位置
                let targetPostion = self.phoneTF.position(from: self.phoneTF.endOfDocument,
                                                          offset: cursorPostion)!
                self.phoneTF.selectedTextRange = self.phoneTF.textRange(from: targetPostion,
                                                                        to: targetPostion)
                return
            }
        }else{
            guard let _: UITextRange = self.pwdTF.markedTextRange else{
                //当前光标的位置（后面会对其做修改）
                let cursorPostion = self.pwdTF.offset(from: (self.pwdTF.endOfDocument),
                                                      to: (self.pwdTF.selectedTextRange!.end))
                //判断非中文的正则表达式
                var pattern = ""
                if loginState == .pwd{
                    pattern = "[0-9]"
                }else{
                    pattern = "[A-Za-z0-9]"
                }
                //            非中文：[^\\u4E00-\\u9FA5]
                //            非英文：[^A-Za-z]
                //            非数字：[^0-9]
                //            非中文或英文：[^A-Za-z\\u4E00-\\u9FA5]
                //            非英文或数字：[^A-Za-z0-9]
                //            非因为或数字或下划线：[^A-Za-z0-9_]
                //替换后的字符串（过滤调非中文字符）
                var str = self.pwdTF.text?.pregReplace(pattern: pattern, with: "")
                if loginState == .pwd{
                    if str?.count ?? 0 > 18 {
                        str = String(str?.prefix(18) ?? "")
                    }
                }else{
                    if str?.count ?? 0 > 6 {
                        str = String(str?.prefix(6) ?? "")
                    }
                }
                self.pwdTF.text = str
                //让光标停留在正确位置
                let targetPostion = self.pwdTF.position(from: self.pwdTF.endOfDocument,
                                                        offset: cursorPostion)!
                self.pwdTF.selectedTextRange = self.pwdTF.textRange(from: targetPostion,
                                                                    to: targetPostion)
                return
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //移除textField内容改变通知监听
        NotificationCenter.default.removeObserver(self,
                                                  name:NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"),
                                                  object: self.phoneTF)
        NotificationCenter.default.removeObserver(self,
                                                  name:NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"),
                                                  object: self.pwdTF)
    }
    @IBAction func changLogin(_ sender: UIButton) {
        loginState = loginState == .code ? LoginState.pwd : LoginState.code
        if loginState == .pwd{
            changeLoginBtn.setTitle("验证码登录", for: .normal)
            pwdLab.text = "密码"
            sendCode.isHidden = true
        }else{
            changeLoginBtn.setTitle("账号密码登录", for: .normal)
            pwdLab.text = "验证码"
            sendCode.isHidden = false
        }
    }
    @IBAction func sendCodeBtnClick(_ sender: UIButton) {
        sender.countDown(count: 60)
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        print(loginState.rawValue)
        if !((self.phoneTF.text ?? "").isMatches(pattern: REGEX_PHONE)) {
            print("电话号码格式错误")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
