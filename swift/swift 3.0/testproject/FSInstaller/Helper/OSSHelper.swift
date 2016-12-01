//
//  OSSHelper.swift
//  initproject-swift
//
//  Created by hqs on 16/4/13.
//  Copyright © 2016年 hqs. All rights reserved.
//

//import UIKit
//import Foundation
//import AliyunOSSiOS
//
//class OSSHelper: NSObject {
//    
//    private static var __once: () = {
//            Inner.instance = OSSHelper()
//            Inner.instance?.setup()
//        }()
//    
//    fileprivate var client: OSSClient!
//    fileprivate var configuration: OSSClientConfiguration!
//    
//    let bucket: String = "fql"
//    
//    struct Inner {
//        static var instance: OSSHelper?
//        static var token: Int = 0
//    }
//
//    /*
//     * 单例模式
//     */
//    class var sharedInstance: OSSHelper {
//        _ = OSSHelper.__once
//        return Inner.instance!
//    }
//    
//    /*
//     * 初始化
//     */
//    fileprivate func setup(){
//        
//        configuration = OSSClientConfiguration()
//        configuration.maxRetryCount = 2                         // 网络请求遇到异常失败后的重试次数
//        configuration.timeoutIntervalForRequest = 30            // 网络请求的超时时间
//        configuration.timeoutIntervalForResource = 60 * 3;      // 允许资源传输的最长时间
//        
//        let endpoint = "oss-cn-beijing.aliyuncs.com"
//        let accessKey = ""
//        let secretKey = ""
//        let provider = OSSPlainTextAKSKPairCredentialProvider(plainTextAccessKey: accessKey, secretKey: secretKey)
//        client = OSSClient(endpoint: endpoint, credentialProvider: provider, clientConfiguration: configuration)
// 
//    }
//    
//    /*
//     * 上传文件
//     */
//    func uploadFile(_ objectKey: String, uploadingData: Data, uploadProgress: @escaping ((_ bytesSent: Int64, _ totalByteSent: Int64, _ totalBytesExpectedToSend:Int64, _ progress: CGFloat) -> ()), completion: @escaping ((_ task: OSSTask<AnyObject>) -> Void)) -> OSSTask<AnyObject>{
//        
//        return self.uploadFile(objectKey, uploadingData: uploadingData, uploadProgress: uploadProgress, completion: completion, waitUntilFinished: false)
//    }
//    /*
//     * 上传文件
//     */
//    func uploadFile(_ objectKey: String, uploadingData: Data, uploadProgress: @escaping ((_ bytesSent: Int64, _ totalByteSent: Int64, _ totalBytesExpectedToSend:Int64, _ progress: CGFloat) -> ()), completion: @escaping ((_ task: OSSTask<AnyObject>) -> Void), waitUntilFinished: Bool) -> OSSTask<AnyObject>{
//        
//        let putRequest = OSSPutObjectRequest()
//        putRequest.bucketName = bucket
//        putRequest.objectKey = objectKey
//        putRequest.uploadingData = uploadingData
//        putRequest.uploadProgress = {
//            (bytesSent, totalByteSent, totalBytesExpectedToSend) in
//            
//            let p = CGFloat(totalByteSent) / CGFloat(totalBytesExpectedToSend)
//            
//            uploadProgress(bytesSent, totalByteSent, totalBytesExpectedToSend, p)
//            
//        }
//        
//        let putTask = client.putObject(putRequest)
//        putTask.continue { (task) -> AnyObject! in
//            completion(task: task)
//            return nil
//        }
//        
//        if waitUntilFinished {
//            putTask?.waitUntilFinished()
//        }
//        
//        return putTask!
//    }
//    
//
//    /*
//     * 下载文件
//     */
//    func downloadFile(_ objectKey: String, downloadProgress: @escaping ((_ bytesWritten: Int64, _ totalBytesWritten: Int64, _ totalBytesExpectedToWrite:Int64, _ progress: CGFloat) -> ()), completion: @escaping ((_ task: OSSTask<AnyObject>) -> Void)) -> OSSTask<AnyObject>{
//        
//        return self.downloadFile(objectKey, downloadProgress: downloadProgress, completion: completion, waitUntilFinished: false)
//    }
//    /*
//     * 下载文件
//     */
//    func downloadFile(_ objectKey: String, downloadProgress: @escaping ((_ bytesWritten: Int64, _ totalBytesWritten: Int64, _ totalBytesExpectedToWrite:Int64, _ progress: CGFloat) -> ()), completion: @escaping ((_ task: OSSTask<AnyObject>) -> Void), waitUntilFinished: Bool) -> OSSTask<AnyObject>{
//        
//        let getRequest = OSSGetObjectRequest()
//        getRequest.bucketName = bucket
//        getRequest.objectKey = objectKey
//        getRequest.downloadProgress = {
//            (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
//            
//            let p = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
//            
//            downloadProgress(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite, p)
//        }
//        
//        
//        let task = client .getObject(getRequest)
//        
//        task.continue { (task) -> AnyObject! in
//            completion(task: task)
//            return nil
//        }
//        
//        if waitUntilFinished {
//            task?.waitUntilFinished()
//        }
//        
//        return task!
//    }
//    
//}
