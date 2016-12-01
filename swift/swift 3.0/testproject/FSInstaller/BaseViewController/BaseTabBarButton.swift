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
    
    var titleColor = UIColor(hexString: "88745e")
    var titleSelectedColor = kAppTitleColor
    
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
        imageView.frame = CGRect(x: x, y: padding, width: wh, height: wh)
        
        let h: CGFloat = frame.size.height - 32 - padding * 3
        titleLabel.frame = CGRect(x: 0, y: frame.size.height - h - padding, width: frame.size.width, height: h)
        
        titleLabel.font = UIFont.systemFont(ofSize: h * 0.99)
        
        if badgeView.isEmpty() {
            badgeView.isHidden = true
        }
        else{
            badgeView.isHidden = false
            
            let bW: CGFloat = 14
            let padding: CGFloat = 4
            
            if badgeView.textLength() > 1 {
                badgeView.frame = CGRect(x: imageView.frame.maxX - padding, y: padding, width: bW * CGFloat(badgeView.textLength()) - 10, height: bW)
            }
            else{
                badgeView.frame = CGRect(x: imageView.frame.maxX - padding, y: padding, width: bW, height: bW)
            }
            
            badgeView.setRoundAppearance(UIColor.clear, cornerRadius: bW * 0.5, backgroundColor: UIColor(hexString: "fc3d39"))
        }
    }
    
    
    fileprivate func setup(){
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(badgeView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(BaseTabBarButton.onTap(_:)))
        addGestureRecognizer(tap)
        
        titleLabel.textAlignment = .center
        badgeView.textAlignment = .center
        badgeView.textColor = UIColor.white
        badgeView.font = UIFont.systemFont(ofSize: 10)
    }
    
    @objc fileprivate func onTap(_ tap: UITapGestureRecognizer){
        guard self.item != nil else {
            return
        }
        
        if selected == false {
            selected = true
        }
        
        onSelectedHandle(item, self)
    }
    
    fileprivate func didSetItem(){
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
            if (item.badgeValue?.length())! > 0 {
                badgeView.text = item.badgeValue
                badgeView.isHidden = false
                return
            }
        }
        badgeView.isHidden = true
        
    }
     
    

}
