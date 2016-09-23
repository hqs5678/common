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
    class func doInMainThreadAfter(_ timeInterval:CGFloat,  task: @escaping (() -> Void)){
        if timeInterval < 0 {
            doInMainThread(task)
        }
        else {
            let time = timeInterval * CGFloat(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(time)) / Double(NSEC_PER_SEC), execute: task)
        }
    }
    
    class func doInMainThread(_ task: @escaping (() -> Void)){
        DispatchQueue.main.async(execute: task)
    }
    
    
    // 在延迟timeInterval时间后在后台线程中执行 task
    class func doInBackgroundAfter(_ timeInterval:CGFloat, task: @escaping (() -> Void)){
        let time = timeInterval * CGFloat(NSEC_PER_SEC)
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).asyncAfter(deadline: DispatchTime.now() + Double(Int64(time)) / Double(NSEC_PER_SEC), execute: task)
    }
    
    // 在后台线程中执行
    class func doInBackground(_ task:@escaping (() -> Void)){
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: task)
    }
    class func doInBackground(_ task:@escaping (() -> Void), completion:@escaping (() -> Void)){
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async { () -> Void in
            task()
            completion()
        }
    }
     
    
    // 将数字转化为字母
    class func num2Char(_ num:Int) -> String {
        let chs:NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let range:NSRange = NSMakeRange(num-1, 1)
        return chs.substring(with: range)
    }
    
    // 用户文件路径
    class func userDocumentDir() -> String{
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
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
    class func createDir(_ path:String) -> String {
        let defaultManager = FileManager.default
        do {
            try defaultManager.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
        } catch {
            
        }
        return path
    }
    
    // 删除文件夹
    class func removeDir(_ path: String) {
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: path) {
            do{
                try fileManager.removeItem(atPath: path)
            } catch let error as NSError {
                print("Could not remove dir at path \(path) \n error: \(error)")
            }
        }
    }
    
    // 有关用户设置
    class func saveToUserDefaults(_ value: AnyObject?, key: String){
        if value != nil {
            let userDef = UserDefaults.standard
            userDef.set(value, forKey: key)
            userDef.synchronize()
        } 
    }
    class func valueForKeyFromUserDefaults(_ key: String) -> AnyObject? {
        let userDef = UserDefaults.standard
        return userDef.object(forKey: key) as AnyObject?
    }
    
    class func curDateString() -> String{
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormat.string(from: date)
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
        return Helper.dateStringWithFormatter(Date())
    }
    class func curTimestamp() -> String{
        return "\(Int(Date().timeIntervalSince1970))"
    }
    
    class func dateStringWithFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
    
    class func dateStringWithFormatter(_ date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    class func uuid() -> String{
        return UUID().uuidString
    }
     
    
    class func fileExists(_ filePath: String) -> Bool {
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    class func removeFileWithFilePath(_ filePath:String) {
        do {
            try FileManager.default.removeItem(atPath: filePath)
        }
        catch {
            print("文件删除失败:\(filePath)")
        }
    }
    
    
}
