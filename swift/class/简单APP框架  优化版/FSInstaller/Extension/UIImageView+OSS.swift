//
//  UIImageView+OSS.swift
//  initproject-swift
//
//  Created by hqs on 16/4/15.
//  Copyright © 2016年 hqs. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    func setOSSObjectKey(objectKey: String){
        self.setOSSObjectKey(objectKey, placeholderImage: nil)
    }
    
    func setOSSObjectKey(objectKey: String, placeholderImage: UIImage?){
        setOSSObjectKey(objectKey, placeholderImage: placeholderImage, downloadProgress: { (progress) in
            
        }) { (data) in
            dispatch_async(dispatch_get_main_queue(), {
                
                self.image = UIImage(data: data)
            })
        }
    }
    
    func setOSSObjectKey(objectKey: String, placeholderImage: UIImage?, downloadProgress: ((progress: CGFloat) -> ()), completion: ((data: NSData) -> Void)){
        
        let fileName = objectKey.md5
        let cachePath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0] + "/"
        let file = cachePath.stringByAppendingString(fileName)
        let fileM = NSFileManager.defaultManager()
        
        
        print(file)
        
        // 判读文件是否存在
        if fileM.fileExistsAtPath(file) {
            self.image = UIImage(contentsOfFile: file)
            completion(data: NSData(contentsOfFile: file)!)
        }
        else{
            if placeholderImage != nil {
                self.image = placeholderImage
            }
            
            OSSHelper.sharedInstance.downloadFile(objectKey, downloadProgress: {
                (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite, progress) in
                
                print("\(objectKey) -> \(progress)")
                
                downloadProgress(progress: progress)
                
            }){
                (task) in
                if task.error == nil {
                    let result = task.result
                    let data:NSData = result.valueForKey("downloadedData") as! NSData
                    
                    completion(data: data)
                    
                    // 保存文件
                    data.writeToFile(file, atomically: false)
                    
                }
                else{
                    print(task.error)
                }
            }
        }
    }


}
