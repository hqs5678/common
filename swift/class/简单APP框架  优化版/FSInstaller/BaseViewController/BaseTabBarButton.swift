//
//  BaseTabBarButton.swift
//  FSInstaller
//
//  Created by Apple on 16/9/6.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


class BaseTabBarButton: UIView {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let badgeView = UILabel()
    
    var selected = false {
        didSet{
            didSetItem()
        }
    }
    
    var padding: CGFloat = 2
    
    var titleColor = UIColor.blackColor()
    var titleSelectedColor = UIColor.whiteColor()
    
    var onSelectedHandle = {
        (item: UITabBarItem, button: BaseTabBarButton) -> Void in
        
        return
    }
    
    var item: UITabBarItem! {
        didSet{
            didSetItem()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let wh: CGFloat = 32
        
        let x: CGFloat = (self.frame.size.width - wh) * 0.5
        imageView.frame = CGRectMake(x, padding, wh, wh)
        
        let h: CGFloat = frame.size.height - 32 - padding * 3
        titleLabel.frame = CGRectMake(0, frame.size.height - h - padding, frame.size.width, h)
        
        titleLabel.font = UIFont.systemFontOfSize(h * 0.99)
        
        if badgeView.isEmpty() {
            badgeView.hidden = true
        }
        else{
            badgeView.hidden = false
            
            let bW: CGFloat = 14
            let padding: CGFloat = 4
            
            if badgeView.textLength() > 1 {
                badgeView.frame = CGRectMake(CGRectGetMaxX(imageView.frame) - padding, padding, bW * CGFloat(badgeView.textLength()) - 10, bW)
            }
            else{
                badgeView.frame = CGRectMake(CGRectGetMaxX(imageView.frame) - padding, padding, bW, bW)
            }
            
            badgeView.setRoundAppearance(UIColor.clearColor(), cornerRadius: bW * 0.5, backgroundColor: UIColor(hexString: "fc3d39"))
        }
    }
    
    
    private func setup(){
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(badgeView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(BaseTabBarButton.onTap(_:)))
        addGestureRecognizer(tap)
        
        titleLabel.textAlignment = .Center
        badgeView.textAlignment = .Center
        badgeView.textColor = UIColor.whiteColor()
        badgeView.font = UIFont.systemFontOfSize(10)
    }
    
    @objc private func onTap(tap: UITapGestureRecognizer){
        guard self.item != nil else {
            return
        }
        
        if selected == false {
            selected = true
        }
        
        onSelectedHandle(item, self)
    }
    
    private func didSetItem(){
        if selected {
            imageView.image = item.selectedImage
            titleLabel.textColor = titleSelectedColor
        }
        else{
            imageView.image = item.image
            titleLabel.textColor = titleColor
        }
        titleLabel.text = item.title
        
        if item.badgeValue != nil {
            if item.badgeValue?.length() > 0 {
                badgeView.text = item.badgeValue
                badgeView.hidden = false
                return
            }
        }
        badgeView.hidden = true
        
    }
    

}
