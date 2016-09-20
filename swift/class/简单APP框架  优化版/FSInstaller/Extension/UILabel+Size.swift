//
//  UILabel+Text.swift
//  formoney
//
//  Created by 火星人 on 16/5/15.
//  Copyright © 2016年 hqs. All rights reserved.
//

extension UILabel {
     
    func boundWithSize(size: CGSize) -> CGRect {
        
        return self.attributedText!.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, context: nil)
    }
}

