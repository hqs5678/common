//
//  CustomerTabBarController.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var isLoining = false
    
    fileprivate var preSelectedIndex = -1
    
    let tabBarButtons = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设定标签栏的背景色和选中的颜色
        self.tabBar.barTintColor = kAppMainColor
        self.tabBar.tintColor=kAppTitleColor
        self.tabBar.isTranslucent = false 
        
        self.delegate = self
       
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if preSelectedIndex != selectedIndex {
            
            if preSelectedIndex >= 0 && preSelectedIndex < tabBarButtons.count {
                let preButton = tabBarButtons.object(at: self.preSelectedIndex) as! BaseTabBarButton
                preButton.selected = false
            }
        }
        preSelectedIndex = self.selectedIndex
        
    }
    
    
    // 优化系统TabBarController
    // 移除 系统tabBar 中的控件 添加自定义的控件
    // 有点: 能够设置tab不同状态的图片, 不会被系统自动渲染
    // 解决: 使用BaseTabBarButton 代替系统 的 tabBarItem, 并添加到tabBar 中
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.removeAllSubviews()
        
        var frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width/CGFloat(self.tabBar.items!.count), height: self.tabBar.frame.size.height)
        
        var i = 0
        for item in self.tabBar.items! {
            let tabBarButton = BaseTabBarButton(frame: frame)
            tabBarButton.item = item
            tabBarButton.tag = i
            tabBarButton.titleColor = UIColor.lightGray
            tabBarButton.titleSelectedColor = kAppTitleColor
            tabBar.addSubview(tabBarButton)
            tabBarButtons.add(tabBarButton)
            
            tabBarButton.onSelectedHandle = {
                [weak self] (item: UITabBarItem, button: BaseTabBarButton) -> Void in
                
                self?.selectedIndex = button.tag
                self?.tabBar((self?.tabBar)!, didSelect: item)
                
                
                
                if item.badgeValue != nil {
                    item.badgeValue = nil
                    button.item = item
                    
                    
                    // 处理有关badge value的逻辑
                    // ........
                }
                
                return
            }
            
            frame.origin.x += frame.size.width
            i += 1
        }
        
        // 设置当前选中
        setCurSelectedIndex(2)
    }
    
    // 设置当前选中项
    fileprivate func setCurSelectedIndex(_ index: Int){
        self.selectedIndex = index
        self.preSelectedIndex = selectedIndex
        let but = tabBarButtons.object(at: self.selectedIndex) as! BaseTabBarButton
        but.selected = true
    }

}


