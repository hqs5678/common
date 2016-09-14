//
//  UIViewController+ImagePicker.swift
//  initproject-swift
//
//  Created by hqs on 16/4/12.
//  Copyright © 2016年 hqs. All rights reserved.
//



extension UIViewController{
    
    /*
     
     使用方法:  
     1, 调起选择图片  selectPic
     2, 覆盖方法     imagePickerController
     
     */
    
    private var imagePickerProcessor: ImagePickerProcessor {
        return ImagePickerProcessor.sharedInstance
    }
    
    func selectSinglePic(){
        let actionSheet = QSAlertController(title: "请选择", message: "", preferredStyle: .ActionSheet)
        var action = UIAlertAction(title: "手机相册", style: .Default) { [weak self] (action: UIAlertAction) in
            
            self?.selectPicFromSource(.PhotoLibrary)
        }
        actionSheet.addAction(action)
        
        action = UIAlertAction(title: "相机", style: .Default) { [weak self] (action: UIAlertAction) in
            self?.selectPicFromSource(.Camera)
            print("相机")
        }
        actionSheet.addAction(action)
        
        action = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        actionSheet.addAction(action)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    func selectMultiPic(){
        let actionSheet = QSAlertController(title: "请选择", message: "", preferredStyle: .ActionSheet)
        var action = UIAlertAction(title: "手机相册", style: .Default) { [weak self] (action: UIAlertAction) in
            self?.selectMultiPic2()
        }
        actionSheet.addAction(action)
        
        action = UIAlertAction(title: "相机", style: .Default) { [weak self] (action: UIAlertAction) in
            self?.selectPicFromSource(.Camera)
            print("相机")
        }
        actionSheet.addAction(action)
        
        action = UIAlertAction(title: "取消", style: .Default, handler: nil)
        actionSheet.addAction(action)
        
        actionSheet.cancelAble = true
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    
    func selectMultiPic2() {
        
        let imagePicker = SGImagePickerController()
        imagePicker.titleColor = kAppTitleColor
        
        imagePicker.navigationBar.barTintColor = self.navigationController?.navigationBar.barTintColor
        imagePicker.navigationBar.tintColor = self.navigationController?.navigationBar.tintColor
        
        imagePicker.statusBarStyleLightContent = false
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
        imagePicker.didFinishSelectImages = {
            [weak self] (images: [AnyObject]!) -> Void in
            
            imagePicker.dismissViewControllerAnimated(true, completion: nil)
            self?.imagePickerController(imagePicker, didFinishPickingImages: images)
        }
    }
    
    
    private func selectPicFromSource(source: UIImagePickerControllerSourceType){
        let imagePickerController = ImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self.imagePickerProcessor
        imagePickerController.sourceType = source
        
        imagePickerController.navigationBar.tintColor = self.navigationController?.navigationBar.tintColor
        imagePickerController.navigationBar.barTintColor = self.navigationController?.navigationBar.barTintColor
        imagePickerController.navigationBar.titleTextAttributes = self.navigationController?.navigationBar.titleTextAttributes
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
        self.imagePickerProcessor.imagePickerDidFinishPickingImage = {
            [weak self] (image: UIImage, picker: UIImagePickerController, editingInfo: [String : AnyObject]?) -> () in
            
            picker.dismissViewControllerAnimated(true, completion: nil)
            self!.imagePickerController(picker, didFinishPickingImage: image, editingInfo: editingInfo)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
    }
    
    func imagePickerController(picker: SGImagePickerController, didFinishPickingImages images: [AnyObject]!) {
        
    }
    
}



class ImagePickerProcessor: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePickerDidFinishPickingImage = {
        (image: UIImage, picker: UIImagePickerController, editingInfo: [String : AnyObject]?) -> () in return
    }
    
    class var sharedInstance: ImagePickerProcessor {
        dispatch_once(&Inner.token) {
            Inner.instance = ImagePickerProcessor()
        }
        return Inner.instance!
    }
    struct Inner {
        static var instance: ImagePickerProcessor?
        static var token: dispatch_once_t = 0
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.imagePickerDidFinishPickingImage(image, picker, editingInfo)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

