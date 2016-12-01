//
//  CustomerNavigationController.swift
//  formoney
//
//  Created by 火星人 on 15/9/15.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    // 记录在跳转之前viewController title
    fileprivate lazy var titles = NSMutableArray()
    fileprivate lazy var action:Int = 0    // 0 add  1 remove
    fileprivate lazy var loadTimes:Int = 0
    fileprivate lazy var isLogining = false
    
    var separatorOverView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setTitleStyle(){
        // 设置导航栏的背景颜色
        self.navigationBar.barTintColor = kAppMainColor
        
        // 设置导航栏字体的颜色
        let attr = [NSForegroundColorAttributeName: kAppTitleColor]
        self.navigationBar.titleTextAttributes = attr
        // 设置导航栏返回字体的颜色
        UINavigationBar.appearance().tintColor = kAppTitleColor
        UINavigationBar.appearance().isTranslucent = false
    }
    
    
    func setup(){
        
        self.popToRootVC = false
        setTitleStyle()
        
        // 去除 navigationBar 下面的一条黑线
        separatorOverView = UIView(frame: CGRect(x: 0, y: self.navigationBar.frame.size.height - 1, width: self.view.frame.size.width, height: 2))
        separatorOverView.backgroundColor = kAppMainColor
        self.navigationBar.addSubview(separatorOverView)
        
        // 禁用右滑返回 手势
        if self.interactivePopGestureRecognizer != nil {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        self.delegate = self
    }
    
    func turnToLogin(){
//        if self.isLogining == false {
//            self.isLogining = true
//            
//            Helper.showTip(withMessage: "请先登录", dismiss: {
//                [weak self] in
//                
//                if self == nil {
//                    return
//                }
//                
//                let loginVC = ControllerHelper.controllerFromStoryBoardWithIdentifier("LoginViewController") as! LoginViewController
//                let naVC = LoginNavigationController(rootViewController: loginVC)
//                self?.present(naVC, animated: true, completion: nil)
//                
//                loginVC.dissmissHandle = {
//                    [weak self] in
//                    self?.setTitleStyle()
//                    self?.isLogining = false
//                }
//            })
//            
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.viewControllers.count > 0 {
            currentViewController = self.viewControllers.last
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
   
        currentViewController = viewController
        
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
        
        loadTimes += 1
//        if UserHelper.isLogined() == false && loadTimes > 2{
//            if navigationController is LoginNavigationController == false {
//                turnToLogin()
//            }
//        }
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 设置BackButtonItem 文字
        if self.titles.count > 0 {
            action = 0
            self.viewControllers[self.viewControllers.count - 1].title = "返回"
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        
        if self.popToRootVC! {
            self.popToRootVC = false
            let vc = self.viewControllers.first
            if self.titles.count > 0 {
                let title = self.titles.firstObject as? String
                if let title = title {
                    vc?.title = title
                    self.titles.removeAllObjects()
                    self.titles.add(title)
                }
            }
            
            return self.popToRootViewController(animated: true)?.first
        }
        
        // 设置BackButtonItem 文字
        if self.titles.count > 0 {
            self.titles.removeLastObject()
            action = 1
            self.viewControllers[self.viewControllers.count - 2].title = self.titles.lastObject! as? String
        }
        
        doInMainThreadAfter(0.6) {
            if self.titles.count > self.viewControllers.count {
                
                while self.titles.count > self.viewControllers.count {
                    self.titles.removeLastObject()
                }
                self.action = 1
                self.viewControllers[self.viewControllers.count - 1].title = self.titles.lastObject as? String
                
            }
        }
        
        if self.viewControllers.count >= 2 {
            currentViewController = self.viewControllers[self.viewControllers.count - 2]
        }
        return super.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        currentViewController = self.viewControllers.first
        return super.popToRootViewController(animated: animated)
    }
    
    // 设置状态栏的样式
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    deinit{
        appPrint("-----deinit \(self.classForCoder)-----")
    }
}
