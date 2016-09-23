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
    
    fileprivate var rightBarButtonHandle = {
        () -> () in
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initData()
        self.view.backgroundColor = kAppBackgroundColor
      
        self.setAppearance()
        
    }
    
    
    func showRightBarButtonWithTitle(_ title: String, handler: @escaping (Void)->(Void)){
        let rightBtn = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(BaseViewController.save))
        self.navigationItem.rightBarButtonItem = rightBtn
        self.rightBarButtonHandle = handler
    }
    
    @objc fileprivate func save(){
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
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardDidHide(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    func keyboardWillShow(_ notification:Notification){
        //获取键盘的高度
        let userInfo:NSDictionary = (notification as NSNotification).userInfo! as NSDictionary
        let value = userInfo[UIKeyboardFrameEndUserInfoKey]
        let rect = (value as AnyObject).cgRectValue
        let height = rect?.size.height
//        print("-----keyboard height ---- \(height) ----")
        App.keyboardHight = height!
    }
    
    func keyboardDidShow(_ notification:Notification){
        
    }
    
    func keyboardWillHide(_ notification:Notification){
        
    }
    
    func keyboardDidHide(_ notification:Notification){
        
    }
    
    func initData(){
        
    }
    
    func setAppearance(){
        
    }
    
    func pushViewControllerWithId(_ storyBoardId:String){
        self.pushViewControllerWithId(storyBoardId, storyBoardName: "Main")
    }
    
    func pushViewControllerWithId(_ storyBoardId:String, storyBoardName:String){
        let vc = ControllerHelper.controllerFromStoryBoardWithIdentifier(storyBoardId, storyBoardName: storyBoardName)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentViewControllerWithId(_ storyBoardId:String){
        self.pushViewControllerWithId(storyBoardId, storyBoardName: "Main")
    }
    
    func presentViewControllerWithId(_ storyBoardId:String, storyBoardName:String){
        let vc = ControllerHelper.controllerFromStoryBoardWithIdentifier(storyBoardId, storyBoardName: storyBoardName)
        self.present(vc, animated: true, completion: nil)
    }
    
    // 设置状态栏的样式
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func makeToast(_ message: String) {
        self.navigationController?.view.makeToast(message)
    }
    
    deinit{
        print("-----deinit \(self.classForCoder)-----")
        // 移除监听器
        if addedKeyboardObserver {
            print("-----移除键盘监听器-----")
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    func pushVC(_ vc: UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popVC(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
