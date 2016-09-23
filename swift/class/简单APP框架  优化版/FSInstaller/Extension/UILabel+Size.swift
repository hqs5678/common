//
//  UILabel+Text.swift
//  formoney
//
//  Created by 火星人 on 16/5/15.
//  Copyright © 2016年 hqs. All rights reserved.
//

extension UILabel {
     
    func boundWithSize(_ size: CGSize) -> CGRect {
        
        return self.attributedText!.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
    }
}

