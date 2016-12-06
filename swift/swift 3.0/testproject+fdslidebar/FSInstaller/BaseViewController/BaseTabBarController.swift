//
//  CustomerTabBarController.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



class BaseTabBarController: UITabBarController {
    
    var isLoining = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设定标签栏的背景色和选中的颜色
        self.tabBar.barTintColor = kTabBarColor
        self.tabBar.tintColor=kAppTitleColor
        self.tabBar.isTranslucent = false 
        
        // 设置选中tab 事件
        let baseBar = self.tabBar as! BaseTabBar
        baseBar.didSelectItemHandle = {
            [weak self] (item: UITabBarItem, tabButton: BaseTabBarButton, index: Int) -> Void in
            self?.selectedIndex = index
             
            
            // 处理badge value
            item.badgeValue = ""
            tabButton.item = item
            
            return
        }
        
        self.selectedIndex = 1
        
        baseBar.currentSelect = self.selectedIndex
    }
    
    
 
}


