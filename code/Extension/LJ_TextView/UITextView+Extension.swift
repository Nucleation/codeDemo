//
//  UITextView+Extension.swift
//  code
//
//  Created by zhishen－mac on 2019/1/23.
//  Copyright © 2019 zhishen－mac. All rights reserved.
//

import UIKit

extension UITextView{
    func selectRange() -> NSRange {
        let beginning: UITextPosition = self.beginningOfDocument
        let selectRange:UITextRange = self.selectedTextRange ?? UITextRange()
        let selectStart:UITextPosition = selectRange.start
        let selectEnd:UITextPosition = selectRange.end
        let location: Int = self.offset(from: beginning, to: selectStart)
        let length: Int = self.offset(from: selectStart, to: selectEnd)
        return NSRange(location: location, length: length)
    }
}
