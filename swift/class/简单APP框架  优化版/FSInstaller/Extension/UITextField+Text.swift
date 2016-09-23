//
//  UITextField+Text.swift
//  formoney
//
//  Created by 火星人 on 16/5/9.
//  Copyright © 2016年 hqs. All rights reserved.
//


extension UITextField {
    
    func isEmpty() -> Bool {
        if  self.text == nil || self.text?.length() == 0 {
            return true
        }
        return false
    }
    
    func textEqualTo(_ textField: UITextField) -> Bool {
        if self.isEmpty() {
            return false
        }
        else {
            if self.text == textField.text {
                return true
            }
            else {
                return false
            }
        }
    }
    
    func setPlaceholderTextColor(_ color: UIColor) {
        self.attributedPlaceholder = NSMutableAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName : color])
    }
}
