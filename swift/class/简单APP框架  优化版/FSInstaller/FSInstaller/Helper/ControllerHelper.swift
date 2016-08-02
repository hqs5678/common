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
    
    
    class var sharedInstance:ControllerHelper {
        struct Instance {
            static var once:dispatch_once_t = 0
            static var instance:ControllerHelper!
        }
        dispatch_once(&Instance.once) { () -> Void in
            Instance.instance = ControllerHelper()
        }
        
        return Instance.instance!
    }
    
    class func storyBoard() -> UIStoryboard {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: NSBundle.mainBundle())
        return storyBoard
    }
    
    class func storyBoardWithName(storyBoardName:String) -> UIStoryboard {
        let storyBoard = UIStoryboard.init(name: storyBoardName, bundle: NSBundle.mainBundle())
        return storyBoard
    }
    
    class func controllerFromStoryBoardWithIdentifier(identifier:String) -> UIViewController {
        let story = storyBoard()
        let vc = story.instantiateViewControllerWithIdentifier(identifier)
        return vc
    }
    
    class func controllerFromStoryBoardWithIdentifier(identifier:String, storyBoardName:String) -> UIViewController {
        let story = storyBoardWithName(storyBoardName);
        let vc = story.instantiateViewControllerWithIdentifier(identifier)
        return vc
    }
     
    
    func actionSheetOfShareToWithDelegate(delegate:UIActionSheetDelegate?) -> UIActionSheet{
        let actionSheet = UIActionSheet(title: "分享到", delegate: delegate!, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "QQ空间","朋友圈","新浪微博")
        actionSheet.tag = actionSheetTagShareTo
        return actionSheet
    }
    
    func actionSheetOfAddSubjectWithDelegate(delegate:UIActionSheetDelegate?) -> UIActionSheet{
        let actionSheet = UIActionSheet(title: "添加题目", delegate: delegate!, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "单选题","多选题","判断题","问答题")
        actionSheet.tag = actionSheetTagAddSubject
        return actionSheet
    }
    
    func imagePickerControllerPhotoLibrary() -> ImagePickerController {
        return imagePicker(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    func imagePickerControllerCamera() -> ImagePickerController {
        return imagePicker(UIImagePickerControllerSourceType.Camera)
    }
    
    private func imagePicker(sourceType:UIImagePickerControllerSourceType) -> ImagePickerController{
        let imagePicker = ImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        
        return imagePicker
    }
    
    func alertViewDeletePicWithDelegate(delegate:UIAlertViewDelegate?) -> UIAlertView {
        let alertView = UIAlertView(title: "", message: "确定要删除该图片?", delegate: delegate, cancelButtonTitle: "取消", otherButtonTitles: "删除")
        
        return alertView
    }
    
    func showAlertTipWithMessage(message: String, vc: UIViewController){
        self.showAlertTipWithMessage(message, vc: vc, handler: nil)
    }
    
    func showAlertTipWithMessage(message: String, vc: UIViewController,handler: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: "温馨提示", message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "确定", style: .Default, handler: handler)
        alert.addAction(action)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    func share(){
        
    }
    
    
}
