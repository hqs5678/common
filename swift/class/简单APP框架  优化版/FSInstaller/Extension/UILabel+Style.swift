//
//  UILabel+Text.swift
//  formoney
//
//  Created by 火星人 on 16/5/15.
//  Copyright © 2016年 hqs. All rights reserved.
//

extension UILabel {
    
    public func setFontColor(fontColor: UIColor, range: NSRange){
        
        let attributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: fontColor, range: range)
        
        self.attributedText = attributedString
    }
    
    // 设置行间距
    func setTextLineSpacing(lineSpacing: CGFloat) {
        
        let len = (self.text! as NSString).length
        let range = NSMakeRange(0, len)
        let attributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        let sourceParagraphStyle = attributedString.attribute(NSParagraphStyleAttributeName, atIndex: 0, longestEffectiveRange: nil, inRange: range)!
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.firstLineHeadIndent = sourceParagraphStyle.firstLineHeadIndent
        paragraphStyle.paragraphSpacing = 0
        paragraphStyle.minimumLineHeight = 4
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        
        self.attributedText = attributedString
    }
    
    // 首行缩进
    func setFirstLineIndentation(indentation: CGFloat) {
        
        let len = (self.text! as NSString).length
        let range = NSMakeRange(0, len)
        let attributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        let sourceParagraphStyle = attributedString.attribute(NSParagraphStyleAttributeName, atIndex: 0, longestEffectiveRange: nil, inRange: range)!
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = sourceParagraphStyle.lineSpacing
        paragraphStyle.firstLineHeadIndent = indentation
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        
        self.attributedText = attributedString
    }
}

