//
//  QSSwitchButton.swift
//  FSInstaller
//
//  Created by Apple on 16/9/13.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class QSSwitchButton: UISwitch {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    var i = 0
    
    private func setup(){
        self.onTintColor = UIColor(hexString: "f0c72e")
        self.tintColor = UIColor(hexString: "bfbfbf")
        
        self.cornerRadius = kCornerRadius
        
        let trans = CGAffineTransformMakeScale(1.2, 0.8)
        self.transform = trans
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        traverseView(self)
//        print("-------------------------------")
        
    }
    
    func traverseView(view: UIView) {
        
//       print("--------------\(i)")
        
        if view.isKindOfClass(UIImageView.classForCoder()){
            let imgView: UIImageView = view as! UIImageView
            
            imgView.image = UIImage(named: "fangkuai")
        }
        
        
        let subviews = view.subviews
        
        // 左
        if i == 5 {
            view.cornerRadius = cornerRadius
        }
    
        // 右
        if i == 3 {
            view.cornerRadius = cornerRadius
        }
        
        i += 1
        
        
        
        
        for sv in subviews {
            traverseView(sv)
        }
    }
    
    

}
