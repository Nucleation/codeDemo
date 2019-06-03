//
//  TextViewViewController.swift
//  code
//
//  Created by zhishen－mac on 2019/1/23.
//  Copyright © 2019 zhishen－mac. All rights reserved.
//

import UIKit

class TextViewViewController: UIViewController ,UITextViewDelegate{
    let textViewFont:UIFont = UIFont.systemFont(ofSize: 17)
    
    lazy var textView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 50, y: 500, width: 150, height: 150))
        textView.font = textViewFont
        textView.isSelectable = true
        textView.returnKeyType = .done
        textView.keyboardType = .default
        textView.isScrollEnabled = true
        textView.delegate = self
        return textView
    }()
    lazy var colorBtn: UIButton = {
        let colorBtn = UIButton(type: .custom)
        colorBtn.frame = CGRect(x: 50, y: 300, width: 80, height: 40)
        colorBtn.backgroundColor = .white
        colorBtn.setTitle("颜色", for: .normal)
        colorBtn.setTitleColor(UIColor.randomColor, for: .normal)
        colorBtn.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        return colorBtn
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyBoardObserver()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(textView)
        self.view.addSubview(colorBtn)
        self.addKeyBoardObserver()
        self.noticeText(text: "提示", fontSize: 16, obliqueness: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        // Do any additional setup after loading the view.
    }
    var moveValue:CGFloat = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(self.keyBoardHeight)
        if textView.maxY > kScreenHeight - self.keyBoardHeight{
            moveValue = self.keyBoardHeight - (kScreenHeight - textView.maxY)
            self.animateViewMoving(up: true, moveValue: moveValue)
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        animateViewMoving(up: false, moveValue: moveValue)
        moveValue = 0
    }
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    func textViewDidChange(_ textView: UITextView) {
        if self.textView.markedTextRange != nil{
            //print(self.textView.markedTextRange)
        }else{
            let mutableStr = NSMutableAttributedString(attributedString: self.textView.attributedText)
            self.textView.attributedText = mutableStr
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.isEmpty {//是删除操作
            return true
        }
        return true
    }
    func insertString(text:String) {
        //获取textView的所有文本，转成可变的文本
        let mutableStr = NSMutableAttributedString(attributedString: textView.attributedText)
        //获得目前光标的位置
        let selectedRange = textView.selectedRange
        //插入文字
        let attStr = NSAttributedString(string: text)
        mutableStr.insert(attStr, at: selectedRange.location)
        
        //设置可变文本的字体属性
        mutableStr.addAttribute(NSAttributedStringKey.font, value: textViewFont,
                                range: NSMakeRange(0,mutableStr.length))
        //再次记住新的光标的位置
        let newSelectedRange = NSMakeRange(selectedRange.location + attStr.length, 0)
        //重新给文本赋值
        textView.attributedText = mutableStr
        //恢复光标的位置（上面一句代码执行之后，光标会移到最后面）
        textView.selectedRange = newSelectedRange
    }
    @objc func changeColor(){
        let range = textView.selectedRange
        if range.length == 0{
            return
        }
        let color = UIColor.randomColor
        let att:NSMutableAttributedString = NSMutableAttributedString(string: textView.text)
        att.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        att.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 17), range: NSRange(textView.text) ?? NSRange(location: 0, length: textView.text.length))
        textView.attributedText = att
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let isSelect:Bool = textView.selectedRange.length > 0
        if (action == #selector(UIResponderStandardEditActions.select(_:)) && isSelect){
            print(textView.selectedRange)
            return true
        }
        return false
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
