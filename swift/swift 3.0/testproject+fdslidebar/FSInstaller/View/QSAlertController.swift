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
    var titleColor = UIColor.black
    var cancelTitleColor = UIColor.red
    var titleFontSize: CGFloat = 15
    var confirmTitleColor = UIColor.blue
    
    var separatorColor = UIColor.lightGray
    
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
    fileprivate var tap: UITapGestureRecognizer!

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
    
    @objc fileprivate func onTap(_ tap: UITapGestureRecognizer){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func traversalView(_ view: UIView){
        
        if view.layer.cornerRadius > 2 {
            view.layer.cornerRadius = cornerRadius
        }
    
        
        if view.isKind(of: UILabel.classForCoder()){
            let label = view as! UILabel
            
            if label.text != nil {
                let text = label.text! as NSString
                
                let len = text.length
                if len > 0 {
                    let attr = NSMutableAttributedString(string: label.text!)
                    
                    let range = NSMakeRange(0, len)
                    if label.text == "取消" {
                        attr.addAttribute(NSForegroundColorAttributeName, value: cancelTitleColor, range: range)
                    }
                    else if label.text == "确定" {
                        attr.addAttribute(NSForegroundColorAttributeName, value: confirmTitleColor, range: range)
                    }
                    else {
                        attr.addAttribute(NSForegroundColorAttributeName, value: titleColor, range: range)
                    }
                    attr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: titleFontSize), range: range)
                    
                    label.attributedText = attr
                }
                
                
            }
        }
        else if view.sizeHeight == 0.5 {
            view.backgroundColor = separatorColor
        }
        
        let subViews = view.subviews
        for sview in subViews {
            traversalView(sview)
        }
    }
    
    deinit {
        appPrint("----- deinit\(self.classForCoder) -----")
    }
    
 

}
