//
//  CustomerNavigationController.swift
//  formoney
//
//  Created by 火星人 on 15/9/15.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    // 记录在跳转之前viewController title
    fileprivate var titles = NSMutableArray()
    fileprivate var action:Int = 0    // 0 add  1 remove
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
        setup()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setup()
    }
    
    fileprivate func setup(){
        // 设置导航栏的背景颜色
        self.navigationBar.barTintColor = kAppMainColor
        
        // 设置导航栏字体的颜色
        let attr = [NSForegroundColorAttributeName: kAppTitleColor]
        self.navigationBar.titleTextAttributes = attr
        // 设置导航栏返回字体的颜色
        UINavigationBar.appearance().tintColor = kAppTitleColor
        UINavigationBar.appearance().isTranslucent = false
        
        let view:UIView = UIView(frame: CGRect(x: 0, y: self.navigationBar.frame.size.height - 1, width: self.view.frame.size.width, height: 2))
        view.backgroundColor = kAppMainColor
        self.navigationBar.addSubview(view)
        
        // 禁用右滑返回 手势
        if self.interactivePopGestureRecognizer != nil {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        self.delegate = self
    }
    
    func turnToLogin(){
//        self.view.makeToast("请登录", position: App.appToastPosition)
//        
//        let loginVC = ControllerHelper.controllerFromStoryBoardWithIdentifier("LoginViewController")
//        self.presentViewController(loginVC, animated: true, completion: nil)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
  
        if UserHelper.isLogined() == false {
            turnToLogin()
        }
        
        
        // 设置BackButtonItem 文字
        if titles.count == 0 {
            titles.add(viewController.title!)
        }
        else{
            if action == 0 {
                // 注意 这个地方出错的原因可能是 将要push 的viewController 没有设置title 导致
                self.titles.add(viewController.title!)
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        
    }
    
    
    
    // 设置 返回按钮的标题为 '返回'   BackButtonItem
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 设置BackButtonItem 文字
        action = 0
        self.viewControllers[self.viewControllers.count - 1].title = "返回"
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        // 设置BackButtonItem 文字
        self.titles.removeLastObject()
        action = 1
        self.viewControllers[self.viewControllers.count - 2].title = self.titles.lastObject! as? String
        return super.popViewController(animated: animated)
    }
    
    
    
    // 设置状态栏的样式
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
