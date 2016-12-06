//
//  PlaceholderTextView.swift
//  FSInstaller
//
//  Created by Apple on 16/8/4.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

class PlaceholderTextView: UITextView, UITextViewDelegate{
    
    lazy var placeholderLabel = UILabel()
    lazy var placeholderLabelPaddingLeft: CGFloat = 8
    lazy var placeholderLabelHeight: CGFloat = 30
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        NotificationCenter.default.addObserver(self, selector: #selector(textChangedForPlaceholderTextView), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.font = UIFont.systemFont(ofSize: 10)
        self.addSubview(placeholderLabel)
    }
    
    func textChangedForPlaceholderTextView(){
        if let text = self.text {
            if text.length() > 0 {
                placeholderLabel.isHidden = true
                return
            }
        }
        placeholderLabel.isHidden = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        placeholderLabel.frame = CGRect(x: placeholderLabelPaddingLeft, y: 0, width: self.sizeWidth - placeholderLabelPaddingLeft * 2, height: placeholderLabelHeight)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }

}
