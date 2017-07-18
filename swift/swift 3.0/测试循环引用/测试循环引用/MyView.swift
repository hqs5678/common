//
//  MyView.swift
//  测试循环引用
//
//  Created by 火星人 on 2017/7/18.
//  Copyright © 2017年 火星人. All rights reserved.
//

import UIKit

typealias Action = () -> Void

class MyView: UIView {
    
    var action: Action
    
    init(action: @escaping Action) {
        self.action = action
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
