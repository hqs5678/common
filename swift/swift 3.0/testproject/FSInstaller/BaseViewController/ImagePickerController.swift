//
//  ImagePickerController.swift
//  formoney
//
//  Created by 火星人 on 15/12/21.
//  Copyright © 2015年 huangqingsong. All rights reserved.
//



class ImagePickerController:UIImagePickerController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设定标签栏的背景色和选中的颜色
        self.navigationBar.barTintColor = kAppMainColor
        // 设置导航栏字体的颜色
        let attr = [NSForegroundColorAttributeName: kAppTitleColor]
        self.navigationBar.titleTextAttributes = attr
        // 设置导航栏返回字体的颜色
        UINavigationBar.appearance().tintColor = kAppTitleColor
        
        // 去除 navigationBar 下面的一条黑线
        let view:UIView = UIView(frame: CGRect(x: 0, y: self.navigationBar.frame.size.height - 1, width: self.view.frame.size.width, height: 2))
        view.backgroundColor = kAppMainColor
        self.navigationBar.addSubview(view)
    }
    
//    override var preferredStatusBarStyle : UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent
//    }
    
    deinit{
        appPrint("-----deinit \(self.classForCoder)-----")
    }
}
