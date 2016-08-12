//
//  QSSlideMenu.swift
//  FSInstaller
//
//  Created by Apple on 16/8/2.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//
 
class QSSlideMenuView: UIView {
 
    private let contentView = UIView()
    private let itemViews = NSMutableArray()
    // 现实菜单背景颜色的view  有灰色背景  或其他颜色
    private let bgView = UIView()
    // 放整个菜单的view  大小为当前 Window 大小  背景颜色透明
    private let bigView = UIView()
    
    private var curSelectedItemView: QSSlideMenuItemView!
    
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
    
    var contentViewFrame = CGRectZero {
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
    
    private func setup(){
        
        self.backgroundColor = UIColor.clearColor()
        
        bgView.backgroundColor = UIColor.blackColor()
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
    
    @objc private func onSelectorInfoMenuTap(tap: UITapGestureRecognizer){
        dismiss()
    }
    
    private func didSetMenu(){
        
        // 添加 菜单项
        if itemViews.count < menuItems.count {
            for i in itemViews.count ..< menuItems.count {
                let itemView = QSSlideMenuItemView()
                itemView.tag = i
                itemViews.addObject(itemView)
                
                self.contentView.addSubview(itemView)
                itemView.didClickItemHandle = {
                    (index: Int) -> Void in
                    if self.currentSelectedIndex != index {
                        let tmpIView = self.curSelectedItemView
                        tmpIView.checked = false
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
        let keyWindow = UIApplication.sharedApplication().keyWindow!
        bigView.frame = keyWindow.frame
        keyWindow.addSubview(bigView)
        
        self.showInView(bigView)
    }
    
    
    func showInView(view: UIView){
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
            
            itemView.backgroundColor = UIColor.whiteColor()
            y += h
        }
 
        
        UIView.animateWithDuration(0.4) {
            self.bgView.alpha = 0.6
        }
        
        for i in 0 ..< self.itemViews.count {
            
            doInMainThreadAfter(CGFloat(i) * 0.1, task: {
                let itemView = self.itemViews[i] as! QSSlideMenuItemView
                
                UIView.animateWithDuration(0.2, animations: {
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
                
                UIView.animateWithDuration(0.2, animations: {
                    var frame = itemView.frame
                    frame.origin.x = -frame.size.width
                    itemView.frame = frame
                })
            })
        }
        
        
        UIView.animateWithDuration(Double(menuItems.count) * 0.1 + 0.2, animations: {
            self.bgView.alpha = 0.0
            
            }) { (complete) in
                
                self.removeFromSuperview()
                self.onDismissCompleted()
        }
        
        
    }
    
    func doInMainThreadAfter(timeInterval:CGFloat,  task: (() -> Void)){
        if timeInterval < 0 {
            dispatch_async(dispatch_get_main_queue(), task)
        }
        else {
            let time = timeInterval * CGFloat(NSEC_PER_SEC)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time)), dispatch_get_main_queue(), task)
        }
    }
    

}

private class QSSlideMenuItemView: UIButton{
    var textLabel = UILabel()
    var imgView = UIImageView()
    
    private var separatorLayer = CALayer()
    var separatorInsets = UIEdgeInsetsZero
    private let separatorHeight: CGFloat = 0.4
    var showSeparator = false {
        didSet{
            self.separatorLayer.hidden = !showSeparator
        }
    }
    
    var didClickItemHandle = {
        (index: Int) -> Void in
        return
    }
    
    private let padding: CGFloat = 10
    private let imgWH: CGFloat = 12
    
    var text = "" {
        didSet{
            textLabel.text = text
        }
    }
    
    var checked = false {
        didSet{
            imgView.hidden = !checked
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        
        textLabel.font = UIFont.systemFontOfSize(14)
        self.addSubview(textLabel)
        
        imgView.contentMode = .ScaleAspectFill
        imgView.image = UIImage(named: "ok.png")
        self.addSubview(self.imgView)
        
        self.setBackgroundImage(UIImage.imageWithColor(UIColor.lightGrayColor().colorWithAlphaComponent(0.3)), forState: .Highlighted)
        self.addTarget(self, action: #selector(QSSlideMenuItemView.onClick), forControlEvents: .TouchUpInside)
        
        separatorLayer.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.4).CGColor
        self.layer.addSublayer(self.separatorLayer)
        separatorLayer.hidden = true
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
            frame = CGRectMake(separatorInsets.left, self.frame.size.height - separatorHeight, self.frame.size.width - separatorInsets.left - separatorInsets.right, separatorHeight)
            separatorLayer.frame = frame
        }
        
    }
    
    @objc private func onClick(){
        didClickItemHandle(self.tag)
        self.checked = true
    }
    
}
