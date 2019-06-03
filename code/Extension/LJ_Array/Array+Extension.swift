//
//  Array+Extension.swift
//  code
//
//  Created by zhishen－mac on 2019/6/3.
//  Copyright © 2019 zhishen－mac. All rights reserved.
//

import Foundation
extension Array {
    mutating func removeAtIndexes (indexs:[Int]) -> () {
        for index in indexs.sorted(by: >) {
            self.remove(at: index)
        }
    }
}
