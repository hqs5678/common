//
//  UserHelper.swift
//  formoney
//
//  Created by 火星人 on 15/9/14.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



let actionSheetTagShareTo = 1
let actionSheetTagSelectPic = 2
let actionSheetTagAddSubject = 3

class ControllerHelper:NSObject {
    
    var delegate:NSObjectProtocol?
    
    static let shared: ControllerHelper = {
        let instance = ControllerHelper()
        // 初始化处理
        instance.setup()
        return instance
    }()
    
    fileprivate func setup(){
        
    }
    
    class func storyBoard() -> UIStoryboard {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyBoard
    }
    
    class func storyBoardWithName(_ storyBoardName:String) -> UIStoryboard {
        let storyBoard = UIStoryboard.init(name: storyBoardName, bundle: Bundle.main)
        return storyBoard
    }
    
    class func controllerFromStoryBoardWithIdentifier(_ identifier:String) -> UIViewController {
        let story = storyBoard()
        let vc = story.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    class func controllerFromStoryBoardWithIdentifier(_ identifier:String, storyBoardName:String) -> UIViewController {
        let story = storyBoardWithName(storyBoardName);
        let vc = story.instantiateViewController(withIdentifier: identifier)
        return vc
    }
     
    
    
    
    func imagePickerControllerPhotoLibrary() -> ImagePickerController {
        return imagePicker(UIImagePickerControllerSourceType.photoLibrary)
    }
    
    func imagePickerControllerCamera() -> ImagePickerController {
        return imagePicker(UIImagePickerControllerSourceType.camera)
    }
    
    fileprivate func imagePicker(_ sourceType:UIImagePickerControllerSourceType) -> ImagePickerController{
        let imagePicker = ImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        
        return imagePicker
    }
    
    func showAlertTipWithMessage(_ message: String, vc: UIViewController){
        self.showAlertTipWithMessage(message, vc: vc, handler: nil)
    }
    
    func showAlertTipWithMessage(_ message: String, vc: UIViewController,handler: ((UIAlertAction) -> Void)?){
        let alert = QSAlertController(title: "温馨提示", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default, handler: handler)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func share(){
        
    }
    
    
    class func tableView(_ tableView: UITableView, registerCellOfNib nibName: String){
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: nibName)
    }
    
    //获取当前屏幕显示的viewcontroller
    func currentVC() -> UIViewController?{
        var vc: UIViewController
        
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            let wins = UIApplication.shared.windows
            for win in wins {
                if win.windowLevel == UIWindowLevelNormal {
                    window = win
                    break
                }
            }
        }
        
        let frontView = window?.subviews.first
        let nextResponder = frontView?.next
        if nextResponder != nil {
            if nextResponder!.isKind(of: UIViewController.classForCoder()) {
                vc = nextResponder as! UIViewController
            }
            else{
                vc = window!.rootViewController!
            }
        }
        else{
            return nil
        }
        return vc
    }
    
    
    
    
}
