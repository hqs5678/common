//
//  OSSHelper.swift
//  initproject-swift
//
//  Created by hqs on 16/4/13.
//  Copyright © 2016年 hqs. All rights reserved.
//

import UIKit
import Foundation
import AliyunOSSiOS

class OSSHelper: NSObject {
    
    private var client: OSSClient!
    private var configuration: OSSClientConfiguration!
    
    let bucket: String = "fql"
    
    struct Inner {
        static var instance: OSSHelper?
        static var token: dispatch_once_t = 0
    }

    /*
     * 单例模式
     */
    class var sharedInstance: OSSHelper {
        dispatch_once(&Inner.token) {
            Inner.instance = OSSHelper()
            Inner.instance?.setup()
        }
        return Inner.instance!
    }
    
    /*
     * 初始化
     */
    private func setup(){
        
        configuration = OSSClientConfiguration()
        configuration.maxRetryCount = 2                         // 网络请求遇到异常失败后的重试次数
        configuration.timeoutIntervalForRequest = 30            // 网络请求的超时时间
        configuration.timeoutIntervalForResource = 60 * 3;      // 允许资源传输的最长时间
        
        let endpoint = "oss-cn-beijing.aliyuncs.com"
        let accessKey = ""
        let secretKey = ""
        let provider = OSSPlainTextAKSKPairCredentialProvider(plainTextAccessKey: accessKey, secretKey: secretKey)
        client = OSSClient(endpoint: endpoint, credentialProvider: provider, clientConfiguration: configuration)
 
    }
    
    /*
     * 上传文件
     */
    func uploadFile(objectKey: String, uploadingData: NSData, uploadProgress: ((bytesSent: Int64, totalByteSent: Int64, totalBytesExpectedToSend:Int64, progress: CGFloat) -> ()), completion: ((task: OSSTask) -> Void)) -> OSSTask{
        
        return self.uploadFile(objectKey, uploadingData: uploadingData, uploadProgress: uploadProgress, completion: completion, waitUntilFinished: false)
    }
    /*
     * 上传文件
     */
    func uploadFile(objectKey: String, uploadingData: NSData, uploadProgress: ((bytesSent: Int64, totalByteSent: Int64, totalBytesExpectedToSend:Int64, progress: CGFloat) -> ()), completion: ((task: OSSTask) -> Void), waitUntilFinished: Bool) -> OSSTask{
        
        let putRequest = OSSPutObjectRequest()
        putRequest.bucketName = bucket
        putRequest.objectKey = objectKey
        putRequest.uploadingData = uploadingData
        putRequest.uploadProgress = {
            (bytesSent, totalByteSent, totalBytesExpectedToSend) in
            
            let p = CGFloat(totalByteSent) / CGFloat(totalBytesExpectedToSend)
            
            uploadProgress(bytesSent: bytesSent, totalByteSent: totalByteSent, totalBytesExpectedToSend: totalBytesExpectedToSend, progress: p)
            
        }
        
        let putTask = client.putObject(putRequest)
        putTask.continueWithBlock { (task) -> AnyObject! in
            completion(task: task)
            return nil
        }
        
        if waitUntilFinished {
            putTask.waitUntilFinished()
        }
        
        return putTask
    }
    

    /*
     * 下载文件
     */
    func downloadFile(objectKey: String, downloadProgress: ((bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite:Int64, progress: CGFloat) -> ()), completion: ((task: OSSTask) -> Void)) -> OSSTask{
        
        return self.downloadFile(objectKey, downloadProgress: downloadProgress, completion: completion, waitUntilFinished: false)
    }
    /*
     * 下载文件
     */
    func downloadFile(objectKey: String, downloadProgress: ((bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite:Int64, progress: CGFloat) -> ()), completion: ((task: OSSTask) -> Void), waitUntilFinished: Bool) -> OSSTask{
        
        let getRequest = OSSGetObjectRequest()
        getRequest.bucketName = bucket
        getRequest.objectKey = objectKey
        getRequest.downloadProgress = {
            (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
            
            let p = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
            
            downloadProgress(bytesWritten: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite, progress: p)
        }
        
        
        let task = client .getObject(getRequest)
        
        task.continueWithBlock { (task) -> AnyObject! in
            completion(task: task)
            return nil
        }
        
        if waitUntilFinished {
            task.waitUntilFinished()
        }
        
        return task
    }
    
}
