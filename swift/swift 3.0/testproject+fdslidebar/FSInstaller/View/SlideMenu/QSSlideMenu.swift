//
//  QSSlideMenu.swift
//  FSInstaller
//
//  Created by Apple on 16/8/2.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//
 
class QSSlideMenuView: UIView {
 
    fileprivate let contentView = UIView()
    fileprivate let itemViews = NSMutableArray()
    // 现实菜单背景颜色的view  有灰色背景  或其他颜色
    fileprivate let bgView = UIView()
    // 放整个菜单的view  大小为当前 Window 大小  背景颜色透明
    fileprivate let bigView = UIView()
    
    fileprivate var curSelectedItemView: QSSlideMenuItemView!
    
    var didSelectMenuItem = {
        (index: Int) -> Void in
        return
    }
    
    var onDismissCompleted = {
        () -> Void in
        return
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var contentViewFrame = CGRect.zero {
        didSet{
            self.contentView.frame = contentViewFrame
        }
    }
    
    var currentSelectedIndex = 0 {
        didSet{
            self.didSelectMenuItem(currentSelectedIndex)
        }
    }
    
    var menuItems: NSArray! {
        didSet{
            didSetMenu()
        }
    }
    
    fileprivate func setup(){
        
        self.backgroundColor = UIColor.clear
        
        bgView.backgroundColor = UIColor.black
        self.addSubview(bgView)
        
        self.addSubview(contentView)
         
        let tap = UITapGestureRecognizer(target: self, action: #selector(QSSlideMenuView.onSelectorInfoMenuTap(_:)))
        bigView.addGestureRecognizer(tap)
        onDismissCompleted = {
            () -> Void in
            self.bigView.removeFromSuperview()
            return
        }
    }
    
    @objc fileprivate func onSelectorInfoMenuTap(_ tap: UITapGestureRecognizer){
        dismiss()
    }
    
    fileprivate func didSetMenu(){
        
        // 添加 菜单项
        if itemViews.count < menuItems.count {
            for i in itemViews.count ..< menuItems.count {
                let itemView = QSSlideMenuItemView()
                itemView.tag = i
                itemViews.add(itemView)
                
                self.contentView.addSubview(itemView)
                itemView.didClickItemHandle = {
                    (index: Int) -> Void in
                    if self.currentSelectedIndex != index {
                        let tmpIView = self.curSelectedItemView
                        tmpIView?.checked = false
                        self.currentSelectedIndex = index
                        self.curSelectedItemView = itemView
                    }
                    return
                }
            }
        }
        
        // 设置菜单内容
        for i in 0 ..< menuItems.count {
            let itemView = itemViews[i] as! QSSlideMenuItemView
            
            itemView.checked = i == currentSelectedIndex
            itemView.text = menuItems[i] as! String
            if itemView.checked {
                self.curSelectedItemView = itemView
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = self.bounds
        frame.size.height += 100
        bgView.frame = frame
        
    }
    
    func show(){
        let keyWindow = UIApplication.shared.keyWindow!
        bigView.frame = keyWindow.frame
        keyWindow.addSubview(bigView)
        
        self.showInView(bigView)
    }
    
    
    func showInView(_ view: UIView){
        bgView.alpha = 0
        
        view.addSubview(self)
        
        var y: CGFloat = 0.0
        let h: CGFloat = contentView.frame.size.height / CGFloat(menuItems.count)
        let w: CGFloat = contentView.frame.size.width
        
        for i in 0 ..< itemViews.count {
            
            let itemView = itemViews[i] as! QSSlideMenuItemView
            
            var frame = itemView.frame
            frame.origin.x = -w
            frame.origin.y = y
            frame.size.width = w
            frame.size.height = h
            itemView.frame = frame
            itemView.showSeparator = i < itemViews.count - 1
            itemView.separatorInsets = UIEdgeInsetsMake(0, 10, 0, 10)
            
            itemView.backgroundColor = UIColor.white
            y += h
        }
 
        
        UIView.animate(withDuration: 0.4, animations: {
            self.bgView.alpha = 0.6
        }) 
        
        for i in 0 ..< self.itemViews.count {
            
            doInMainThreadAfter(CGFloat(i) * 0.1, task: {
                let itemView = self.itemViews[i] as! QSSlideMenuItemView
                
                UIView.animate(withDuration: 0.2, animations: {
                    var frame = itemView.frame
                    frame.origin.x = 0
                    itemView.frame = frame
                })
            })
        }
    }
    
    func dismiss() {
        
        for i in 0 ..< self.itemViews.count {
            
            doInMainThreadAfter(CGFloat(i) * 0.1, task: {
                let itemView = self.itemViews[self.itemViews.count - 1 - i] as! QSSlideMenuItemView
                
                UIView.animate(withDuration: 0.2, animations: {
                    var frame = itemView.frame
                    frame.origin.x = -frame.size.width
                    itemView.frame = frame
                })
            })
        }
        
        
        UIView.animate(withDuration: Double(menuItems.count) * 0.1 + 0.2, animations: {
            self.bgView.alpha = 0.0
            
            }, completion: { (complete) in
                
                self.removeFromSuperview()
                self.onDismissCompleted()
        }) 
        
        
    }
    
    func doInMainThreadAfter(_ timeInterval:CGFloat,  task: @escaping (() -> Void)){
        if timeInterval < 0 {
            DispatchQueue.main.async(execute: task)
        }
        else {
            let time = timeInterval * CGFloat(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(time)) / Double(NSEC_PER_SEC), execute: task)
        }
    }
    

}

private class QSSlideMenuItemView: UIButton{
    var textLabel = UILabel()
    var imgView = UIImageView()
    
    fileprivate var separatorLayer = CALayer()
    var separatorInsets = UIEdgeInsets.zero
    fileprivate let separatorHeight: CGFloat = 0.4
    var showSeparator = false {
        didSet{
            self.separatorLayer.isHidden = !showSeparator
        }
    }
    
    var didClickItemHandle = {
        (index: Int) -> Void in
        return
    }
    
    fileprivate let padding: CGFloat = 10
    fileprivate let imgWH: CGFloat = 12
    
    var text = "" {
        didSet{
            textLabel.text = text
        }
    }
    
    var checked = false {
        didSet{
            imgView.isHidden = !checked
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup(){
        
        textLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(textLabel)
        
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(named: "ok.png")
        self.addSubview(self.imgView)
        
        self.setBackgroundImage(UIImage.imageWithColor(UIColor.lightGray.withAlphaComponent(0.3)), for: .highlighted)
        self.addTarget(self, action: #selector(QSSlideMenuItemView.onClick), for: .touchUpInside)
        
        separatorLayer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        self.layer.addSublayer(self.separatorLayer)
        separatorLayer.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = self.bounds
        frame.origin.x = padding
        textLabel.frame = frame
        
        frame = imgView.frame
        frame.size.height = imgWH
        frame.size.width = imgWH
        frame.origin.x = self.frame.width - padding - frame.size.width - 4
        frame.origin.y = (self.frame.size.height - imgWH) * 0.5
        imgView.frame = frame
        
        // 分割线
        if showSeparator {
            frame = CGRect(x: separatorInsets.left, y: self.frame.size.height - separatorHeight, width: self.frame.size.width - separatorInsets.left - separatorInsets.right, height: separatorHeight)
            separatorLayer.frame = frame
        }
        
    }
    
    @objc fileprivate func onClick(){
        didClickItemHandle(self.tag)
        self.checked = true
    }
    
}
