//
//  CustomerViewController.swift
//  formoney
//
//  Created by 火星人 on 15/9/20.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



class BaseViewController: UIViewController {
    var hiddenTabBar = true
    var addedKeyboardObserver = false
    
    private var rightBarButtonHandle = {
        () -> () in
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initData()
        self.view.backgroundColor = kAppBackgroundColor
      
        self.setAppearance()
        
    }
    
    
    func showRightBarButtonWithTitle(title: String, handler: (Void)->(Void)){
        let rightBtn = UIBarButtonItem(title: title, style: .Plain, target: self, action: #selector(BaseViewController.save))
        self.navigationItem.rightBarButtonItem = rightBtn
        self.rightBarButtonHandle = handler
    }
    
    @objc private func save(){
        rightBarButtonHandle()
    }
    
    
    func addKeyboardObserver(){
        if addedKeyboardObserver {
            return
        } else {
            addedKeyboardObserver = true
        }
        print("-----添加键盘监听器-----")
        // 监听键盘  添加监听器
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseViewController.keyboardDidHide(_:)), name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification:NSNotification){
        //获取键盘的高度
        let userInfo:NSDictionary = notification.userInfo!
        let value = userInfo[UIKeyboardFrameEndUserInfoKey]
        let rect = value?.CGRectValue
        let height = rect?.size.height
//        print("-----keyboard height ---- \(height) ----")
        App.keyboardHight = height!
    }
    
    func keyboardDidShow(notification:NSNotification){
        
    }
    
    func keyboardWillHide(notification:NSNotification){
        
    }
    
    func keyboardDidHide(notification:NSNotification){
        
    }
    
    func initData(){
        
    }
    
    func setAppearance(){
        
    }
    
    func pushViewControllerWithId(storyBoardId:String){
        self.pushViewControllerWithId(storyBoardId, storyBoardName: "Main")
    }
    
    func pushViewControllerWithId(storyBoardId:String, storyBoardName:String){
        let vc = ControllerHelper.controllerFromStoryBoardWithIdentifier(storyBoardId, storyBoardName: storyBoardName)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentViewControllerWithId(storyBoardId:String){
        self.pushViewControllerWithId(storyBoardId, storyBoardName: "Main")
    }
    
    func presentViewControllerWithId(storyBoardId:String, storyBoardName:String){
        let vc = ControllerHelper.controllerFromStoryBoardWithIdentifier(storyBoardId, storyBoardName: storyBoardName)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // 设置状态栏的样式
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func makeToast(message: String) {
        self.navigationController?.view.makeToast(message)
    }
    
    deinit{
        print("-----deinit \(self.classForCoder)-----")
        // 移除监听器
        if addedKeyboardObserver {
            print("-----移除键盘监听器-----")
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
    func pushVC(vc: UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popVC(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
}
