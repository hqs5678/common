//
//  RefreshNormalHeader.swift
//  FSInstaller
//
//  Created by Apple on 16/8/12.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import MJRefresh

class RefreshNormalHeader: MJRefreshGifHeader { //MJRefreshNormalHeader {
    
    fileprivate let headerTopView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func setup(){
        
        self.addSubview(headerTopView)
        
//        self.activityIndicatorViewStyle = .white
//        self.arrowView.image = UIImage(named: "arrow_down")
        
        
        
        self.backgroundColor = kRefreshBackgroundColor
        
        var imgs = [UIImage]()
        var imgs1 = [UIImage]()
        var imgs2 = [UIImage]()
        
        for i in 1 ... 3 {
            let image = UIImage(named: "bird\(i)")
            imgs.append(image!)
        }
        var image = UIImage(named: "bird1")
        imgs1.append(image!)
        
        image = UIImage(named: "bird3")
        imgs2.append(image!)
        
        self.setImages(imgs, for: .refreshing)
        self.setImages(imgs2, for: .pulling)
        self.setImages(imgs1, for: .idle)
        self.setImages(imgs2, for: .willRefresh)
        
        self.stateLabel.isHidden = true
        self.lastUpdatedTimeLabel.isHidden = true
        
        
        traversal(self)
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = self.bounds
        let h: CGFloat = 200
        frame.origin.y = -h
        frame.size.height = h
        headerTopView.frame = frame
        headerTopView.backgroundColor = backgroundColor
        self.layer.masksToBounds = false
    }
    
    // 修改label 字体颜色
    fileprivate func traversal(_ view: UIView){
        if view.isKind(of: UILabel.classForCoder()){
            let label = view as! UILabel
            label.textColor = UIColor.white
        }
        
        let subViews = view.subviews
        if  subViews.count > 0 {
            for v in view.subviews {
                traversal(v)
            }
        }
        
    }
}
