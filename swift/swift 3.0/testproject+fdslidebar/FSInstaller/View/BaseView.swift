//
//  BaseView.swift
//  testmyview
//
//  Created by Apple on 16/9/18.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class BaseView: UIView {

    
    fileprivate var tmpView: BaseView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    // 注意: 需要 重写这个
    func viewFromNib() -> BaseView {
        return Bundle.main.loadNibNamed("BaseView", owner: nil, options: nil)!.first as! BaseView
    }
    
    fileprivate func setupSubviews(){
        
        self.tmpView = self.viewFromNib()
        tmpView.frame = self.bounds
        tmpView.backgroundColor = UIColor.clear
        self.addSubview(tmpView)
        
        self.copyPropertiesReferenceFromView(self.tmpView) 
    }
    
    // 注意: 需要 重写这个
    func setup(){
        
        if self.subviews.count == 0 {
            setupSubviews()
        }
        
        
    }
}
