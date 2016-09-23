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
    
    fileprivate var imagePickerProcessor: ImagePickerProcessor {
        return ImagePickerProcessor.sharedInstance
    }
    
    func selectSinglePic(){
        let actionSheet = QSAlertController(title: "请选择", message: "", preferredStyle: .actionSheet)
        var action = UIAlertAction(title: "手机相册", style: .default) { [weak self] (action: UIAlertAction) in
            
            self?.selectPicFromSource(.photoLibrary)
        }
        actionSheet.addAction(action)
        
        action = UIAlertAction(title: "相机", style: .default) { [weak self] (action: UIAlertAction) in
            self?.selectPicFromSource(.camera)
            print("相机")
        }
        actionSheet.addAction(action)
        
        action = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        actionSheet.addAction(action)
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func selectMultiPic(){
        let actionSheet = QSAlertController(title: "请选择", message: "", preferredStyle: .actionSheet)
        var action = UIAlertAction(title: "手机相册", style: .default) { [weak self] (action: UIAlertAction) in
            self?.selectMultiPic2()
        }
        actionSheet.addAction(action)
        
        action = UIAlertAction(title: "相机", style: .default) { [weak self] (action: UIAlertAction) in
            self?.selectPicFromSource(.camera)
            print("相机")
        }
        actionSheet.addAction(action)
        
        action = UIAlertAction(title: "取消", style: .default, handler: nil)
        actionSheet.addAction(action)
        
        actionSheet.cancelAble = true
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    func selectMultiPic2() {
        
        let imagePicker = SGImagePickerController()
        imagePicker.tintColor = kAppTitleColor
        imagePicker.barTintColor = self.navigationController?.navigationBar.barTintColor
        
        imagePicker.statusBarStyleLightContent = false
        
        self.present(imagePicker, animated: true, completion: nil)
        
        imagePicker.didFinishSelectImages = {
            [weak self] (picker, images: [Any]?) -> Void in
            
            picker!.dismiss(animated: true, completion: nil)
            self?.imagePickerController(picker!, didFinishPickingImages: images as [AnyObject]!)
        }
    }
    
    
    fileprivate func selectPicFromSource(_ source: UIImagePickerControllerSourceType){
        let imagePickerController = ImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self.imagePickerProcessor
        imagePickerController.sourceType = source
        
        self.present(imagePickerController, animated: true, completion: nil)
        
        self.imagePickerProcessor.imagePickerDidFinishPickingImage = {
            [weak self] (image: UIImage, picker: UIImagePickerController, editingInfo: [String : AnyObject]?) -> () in
            
            picker.dismiss(animated: true, completion: nil)
            self!.imagePickerController(picker, didFinishPickingImage: image, editingInfo: editingInfo)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
    }
    
    func imagePickerController(_ picker: SGImagePickerController, didFinishPickingImages images: [AnyObject]!) {
        
    }
    
}



class ImagePickerProcessor: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private static var __once: () = {
            Inner.instance = ImagePickerProcessor()
        }()
    
    var imagePickerDidFinishPickingImage = {
        (image: UIImage, picker: UIImagePickerController, editingInfo: [String : AnyObject]?) -> () in return
    }
    
    class var sharedInstance: ImagePickerProcessor {
        _ = ImagePickerProcessor.__once
        return Inner.instance!
    }
    struct Inner {
        static var instance: ImagePickerProcessor?
        static var token: Int = 0
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        picker.dismiss(animated: true, completion: nil)
        self.imagePickerDidFinishPickingImage(image, picker, editingInfo)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

