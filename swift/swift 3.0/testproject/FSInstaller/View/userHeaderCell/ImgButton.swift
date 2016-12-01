//
//  ImgButton.swift
//  FSInstaller
//
//  Created by Apple on 16/9/9.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


class ImgButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    fileprivate func setup(){
        
        self.titleLabel?.textAlignment = .center
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let x: CGFloat = 0
        let y: CGFloat = 0
        let w: CGFloat = self.frame.size.width - x * 2
        let h: CGFloat = self.frame.size.height * 0.4
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let imgRect = self.imageRect(forContentRect: contentRect)
        let x: CGFloat = 0
        let y: CGFloat = imgRect.maxY
        let w: CGFloat = self.frame.size.width - x * 2
        let h: CGFloat = self.frame.size.height - imgRect.size.height
        return CGRect(x: x, y: y, width: w, height: h)
    }

}
