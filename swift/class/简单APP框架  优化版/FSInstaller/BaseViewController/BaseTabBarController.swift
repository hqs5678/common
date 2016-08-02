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
        self.tabBar.barTintColor=App.appMainColor
        self.tabBar.tintColor=App.appTitleColor
        self.tabBar.translucent = false 
        
        
        self.selectedIndex = 2
//        
//        let h1 = HttpHelper.sharedInstance
//        
//        let para = NSMutableDictionary()
//        para.setValue("hello", forKey: "key")
//        
//        h1.postRequestWithUrl("https://api.ainia.com.cn/api.php/DoctorSystem/signUp", params: para) { (isSuccess, content) -> () in
//        }
//        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}
