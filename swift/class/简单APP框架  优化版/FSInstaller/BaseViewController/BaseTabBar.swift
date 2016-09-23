//
//  BaseTabBar.swift
//  FSInstaller
//
//  Created by Apple on 16/9/23.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

// 优化系统TabBarController
// 移除 系统tabBar 中的控件 添加自定义的控件
// 有点: 能够设置tab不同状态的图片, 不会被系统自动渲染
// 解决: 使用BaseTabBarButton 代替系统 的 tabBarItem, 并添加到tabBar 中

class BaseTabBar: UITabBar {
 
    fileprivate var preSelectedIndex = -1
    var currentSelect = -1 {
        didSet{
            self.updateSelectedItemIndex()
        }
    }
    
    let tabBarButtons = NSMutableArray()
    
    lazy var didSelectItemHandle = {
        (item: UITabBarItem,tabButton: BaseTabBarButton, index: Int) -> Void in return
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        self.removeAllSubviews()
    }
    
    override func addSubview(_ view: UIView) {
        if view.tag > 100 {
            super.addSubview(view)
        }
    }
    
    override func layoutSubviews() {
        guard self.items != nil else {
            return
        }
        
        if self.tabBarButtons.count == items?.count {
            return
        }
        
        self.removeAllSubviews()
        tabBarButtons.removeAllObjects()
        
        print("----------- 为自定义的tab bar 添加view ------------")
        
        self.backgroundColor = self.barTintColor
        
        var frame = CGRect(x: 0, y: 0, width: self.frame.size.width/CGFloat(self.items!.count), height: self.frame.size.height)
        
        var i = 0
        for item in self.items! {
            let tabBarButton = BaseTabBarButton(frame: frame)
            tabBarButton.item = item
            tabBarButton.tag = i + 111
            tabBarButton.titleColor = UIColor.lightGray
            tabBarButton.titleSelectedColor = kAppTitleColor
            tabBarButton.selected = i == currentSelect
            self.addSubview(tabBarButton)
            tabBarButtons.add(tabBarButton)
            
            tabBarButton.onSelectedHandle = {
                [weak self] (item: UITabBarItem, button: BaseTabBarButton) -> Void in
                
                if let wself = self { 
                    wself.currentSelect = button.tag - 111
                    self?.updateSelectedItemIndex()
                    
                    wself.didSelectItemHandle(item, button, wself.currentSelect)
                }
                
                return
            }
            
            frame.origin.x += frame.size.width
            i += 1
        }
    }
    
    private func updateSelectedItemIndex(){
        if self.currentSelect != preSelectedIndex{
            if preSelectedIndex > -1 && preSelectedIndex < items!.count {
                let but = tabBarButtons.object(at: preSelectedIndex) as! BaseTabBarButton
                but.selected = false
            }
            preSelectedIndex = currentSelect
        }
    }
}
