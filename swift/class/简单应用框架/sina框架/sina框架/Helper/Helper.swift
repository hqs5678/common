//
//  Helper.swift
//  formoney
//
//  Created by 火星人 on 15/12/24.
//  Copyright © 2015年 huangqingsong. All rights reserved.
//

//// 通用帮助类


class Helper {
    
    // 在延迟timeInterval时间后在主线程中执行 task
    class func doInMainThreadAfter(timeInterval:CGFloat,  task: (() -> Void)){
        if timeInterval < 0 {
            doInMainThread(task)
        }
        else {
            let time = timeInterval * CGFloat(NSEC_PER_SEC)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time)), dispatch_get_main_queue(), task)
        }
    }
    
    class func doInMainThread(task: (() -> Void)){
        dispatch_async(dispatch_get_main_queue(), task)
    }
    
    
    // 在延迟timeInterval时间后在后台线程中执行 task
    class func doInBackgroundAfter(timeInterval:CGFloat, task: (() -> Void)){
        let time = timeInterval * CGFloat(NSEC_PER_SEC)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), task)
    }
    
    // 在后台线程中执行
    class func doInBackground(task:(() -> Void)){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), task)
    }
    class func doInBackground(task:(() -> Void), completion:(() -> Void)){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            task()
            completion()
        }
    }
     
    
    // 将数字转化为字母
    class func num2Char(num:Int) -> String {
        let chs:NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let range:NSRange = NSMakeRange(num-1, 1)
        return chs.substringWithRange(range)
    }
    
    // 用户文件路径
    class func userDocumentDir() -> String{
        return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
    }
    
    // 调查问卷路径
    class func userQuestionnaireDir() -> String{
        let path = Helper.userDocumentDir() + "/questionnaire"
        return createDir(path)
    }
    
    
    // 图片路径
    class func userImageDir() -> String {
        let path = userDocumentDir() + "/imgs"
        return createDir(path)
    }
    
    // 创建文件夹
    class func createDir(path:String) -> String {
        let defaultManager = NSFileManager.defaultManager()
        do {
            try defaultManager.createDirectoryAtPath(path, withIntermediateDirectories: false, attributes: nil)
        } catch {
            
        }
        return path
    }
    
    // 删除文件夹
    class func removeDir(path: String) {
        let fileManager = NSFileManager.defaultManager()
        
        if fileManager.fileExistsAtPath(path) {
            do{
                try fileManager.removeItemAtPath(path)
            } catch let error as NSError {
                print("Could not remove dir at path \(path) \n error: \(error)")
            }
        }
    }
    
    // 有关用户设置
    class func saveToUserDefaults(value: AnyObject?, key: String){
        if value != nil {
            let userDef = NSUserDefaults.standardUserDefaults()
            userDef.setObject(value, forKey: key)
            userDef.synchronize()
        } 
    }
    class func valueForKeyFromUserDefaults(key: String) -> AnyObject? {
        let userDef = NSUserDefaults.standardUserDefaults()
        return userDef.objectForKey(key)
    }
    
    class func curDateString() -> String{
        let date = NSDate()
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormat.stringFromDate(date)
    }
    
//    class func dismissProgressWithCompletion(completion: KVNCompletionBlock!){
//        KVNProgress.dismissWithCompletion(completion)
//    }
//    
//    class func dismissProgress(){
//        KVNProgress.dismiss()
//    }
//    
//    class func showProgressWithStatus(status: String){
//        KVNProgress.showWithStatus(status)
//    }
//    
//    class func showProgressWithStatus(progress: CGFloat, status: String){
//        KVNProgress.showProgress(progress, status: status)
//    }
//    
//    class func showErrorWithStatus(status: String){
//        KVNProgress.showErrorWithStatus(status)
//    }
//    
//    class func showErrorWithStatus(status: String, completion:KVNCompletionBlock){
//        KVNProgress.showErrorWithStatus(status, completion: completion)
//    }
//    
//    class func showSuccessWithStatus(status:String){
//        KVNProgress.showSuccessWithStatus(status)
//    }
//    class func showSuccessWithStatus(status:String, completion:KVNCompletionBlock){
//        KVNProgress.showSuccessWithStatus(status, completion: completion)
//    }
//    class func isShowingKVN() -> Bool{
//        return KVNProgress.isVisible()
//    }
    
    
    // 有关时间
    class func curTimeString() -> String {
        return Helper.dateStringWithFormatter(NSDate())
    }
    class func curTimestamp() -> String{
        return "\(Int(NSDate().timeIntervalSince1970))"
    }
    
    class func dateStringWithFormatter(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.stringFromDate(date)
    }
    
    class func dateStringWithFormatter(date: NSDate, format: String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(date)
    }
    
    class func uuid() -> String{
        return NSUUID().UUIDString
    }
     
    
    class func fileExists(filePath: String) -> Bool {
        return NSFileManager.defaultManager().fileExistsAtPath(filePath)
    }
    
    class func removeFileWithFilePath(filePath:String) {
        do {
            try NSFileManager.defaultManager().removeItemAtPath(filePath)
        }
        catch {
            print("文件删除失败:\(filePath)")
        }
    }
    
    
}