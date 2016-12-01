//
//  CustomerViewController.swift
//  formoney
//
//  Created by 火星人 on 15/9/20.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



class BaseViewController: UIViewController {
    
    var addedKeyboardObserver = false
    
    fileprivate var rightBarButtonHandle = {
        () -> () in
        return
    }
    
    fileprivate var leftBarButtonHandle = {
        () -> () in
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initData()
        self.view.backgroundColor = kAppBackgroundColor
      
        self.setAppearance()
        
        UIApplication.shared.isStatusBarHidden = false
    }
    
    
    func showRightBarButtonWithTitle(_ title: String, handler: @escaping ()->()){
        let rightBtn = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(BaseViewController.rightItemClick))
        self.navigationItem.rightBarButtonItem = rightBtn
        self.rightBarButtonHandle = handler
    }
    
    func showLeftBarButtonWithTitle(_ title: String, handler: @escaping ()->()){
        let leftItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(BaseViewController.leftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
        self.leftBarButtonHandle = handler
    }
    
    @objc fileprivate func rightItemClick(){
        rightBarButtonHandle()
    }
    
    @objc fileprivate func leftItemClick(){
        leftBarButtonHandle()
    }
    
    
    func addKeyboardObserver(){
        if addedKeyboardObserver {
            return
        } else {
            addedKeyboardObserver = true
        }
        appPrint("-----添加键盘监听器-----")
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
//        appPrint("-----keyboard height ---- \(height) ----")
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
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.default
    }
    
    
     
    deinit{
        appPrint("-----deinit \(self.classForCoder)-----")
        // 移除监听器
        if addedKeyboardObserver {
            appPrint("-----移除键盘监听器-----")
            NotificationCenter.default.removeObserver(self)
        }
    }
}
