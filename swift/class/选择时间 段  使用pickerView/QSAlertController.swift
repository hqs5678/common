//
//  QSAlertController.swift
//  testActionAlert
//
//  Created by Apple on 16/8/9.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


class QSAlertController: UIAlertController {
    
    // 设定圆角大小
    var cornerRadius: CGFloat = 5
    var titleColor = UIColor.blackColor()
    var cancelTitleColor = UIColor.redColor()
    var titleFontSize: CGFloat = 15
    
    // 当不添加 cancel 按钮时 点击灰色的区域时  dismiss
    var cancelAble = false {
        didSet{
            if cancelAble {
                tap = UITapGestureRecognizer(target: self, action: #selector(QSAlertController.onTap(_:)))
            }
            else {
                tap = nil
            }
        }
    }
    private var tap: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if cancelAble && tap != nil {
            // 添加手势  点击灰色的区域dismiss
            let superView = self.view.superview?.subviews.first
            superView?.addGestureRecognizer(tap)
        }
        
        
        // 遍历view tree
        traversalView(self.view)
    }
    
    @objc private func onTap(tap: UITapGestureRecognizer){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func traversalView(view: UIView){
        
        if view.layer.cornerRadius > 2 {
            view.layer.cornerRadius = cornerRadius
        }
        
        if view.isKindOfClass(UILabel.classForCoder()){
            let label = view as! UILabel
            label.textColor = UIColor.grayColor()
            
            
            if label.text != nil {
                let text = label.text! as NSString
                
                let len = text.length
                if len > 0 {
                    let attr = NSMutableAttributedString(string: label.text!)
                    
                    let range = NSMakeRange(0, len)
                    if label.text == "取消" {
                        attr.addAttribute(NSForegroundColorAttributeName, value: cancelTitleColor, range: range)
                    }
                    else {
                        attr.addAttribute(NSForegroundColorAttributeName, value: titleColor, range: range)
                    }
                    attr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(titleFontSize), range: range)
                    
                    label.attributedText = attr
                }
                
                
            }
        }
        
        let subViews = view.subviews
        for sview in subViews {
            traversalView(sview)
        }
    }
    
    
    
 

}
