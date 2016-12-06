//
//  Helper.swift
//  formoney
//
//  Created by 火星人 on 15/12/24.
//  Copyright © 2015年 huangqingsong. All rights reserved.
//

//// 通用帮助类

import MBProgressHUD

class Helper {
    
    private static var annularDeterminateProgressHud: MBProgressHUD?
    private static var progressHud: MBProgressHUD?
    private static var currentProgressHud: MBProgressHUD?
    private static var progressHudContentView: UIView?
    
    // MARK: 将数字转化为字母
    class func num2Char(_ num:Int) -> String {
        let chs:NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let range:NSRange = NSMakeRange(num-1, 1)
        return chs.substring(with: range)
    }
    
    
    
    // MARK: 有关用户设置
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
    
    
    
    
    
    
    // MARK: 有关用户提示
    
    class func showProgressHUD() {
        
        annularDeterminateProgressHud?.isHidden = true
        
        let keyWindow = UIApplication.shared.keyWindow
        if progressHudContentView == nil {
            progressHudContentView = UIView(frame: keyWindow!.frame)
        }
        keyWindow?.addSubview(progressHudContentView!)
  
        if progressHud == nil {
            progressHud = MBProgressHUD.showAdded(to: progressHudContentView!, animated: true)
            progressHud!.contentColor = kProgressTintColor
            progressHud!.bezelView.color = kAppBackgroundColor
            progressHud!.bezelView.style = .solidColor
            progressHud!.removeFromSuperViewOnHide = false
            progressHud?.mode = .indeterminate
            
            // 点击隐藏
            progressHud?.addTapWithHandle({ (tap) in
                hideProgressHUD()
            })
            progressHud?.bezelView.addTapWithHandle({ (tap) in
                
            })
        }
        
        progressHud?.isHidden = false
        
        currentProgressHud = progressHud
    }
    
    class func showProgress(progress: CGFloat) {
        Helper.showProgress(progress: progress, preDescMessage: nil)
    }
    
    class func showProgress(progress: CGFloat, preDescMessage: String?) {
        
        progressHud?.isHidden = true
        
        let keyWindow = UIApplication.shared.keyWindow
        if progressHudContentView == nil {
            progressHudContentView = UIView(frame: keyWindow!.frame)
        }
        keyWindow?.addSubview(progressHudContentView!)
        
        if annularDeterminateProgressHud == nil {
            annularDeterminateProgressHud = MBProgressHUD.showAdded(to: progressHudContentView!, animated: true)
            annularDeterminateProgressHud!.contentColor = kAppTitleColor
            annularDeterminateProgressHud!.bezelView.color = kAppBackgroundColor
            annularDeterminateProgressHud!.bezelView.style = .blur
            annularDeterminateProgressHud!.removeFromSuperViewOnHide = false
            annularDeterminateProgressHud!.mode = .annularDeterminate
            annularDeterminateProgressHud!.minSize = CGSize(width: progressHudContentView!.sizeWidth * 0.5, height: 0)
        }
        
        currentProgressHud = annularDeterminateProgressHud
        annularDeterminateProgressHud?.isHidden = false
        
        annularDeterminateProgressHud?.progress = Float(progress)
        let proStr = String(format: "%.02f%%", progress * 100)
        if preDescMessage == nil {
            annularDeterminateProgressHud?.label.text = proStr
        }
        else{
            annularDeterminateProgressHud?.label.text = preDescMessage! + proStr
        }
    }

    
    class func hideProgressHUD() {
        
        currentProgressHud?.isHidden = true
        progressHudContentView?.removeFromSuperview()
    }
    
    class func showTip(withMessage message: String, dismiss: (() -> Void)?) {
        
        if let vc = currentViewController {
            let alertVC = QSAlertController(title: nil, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                dismiss?()
            })
            alertVC.addAction(action)
            alertVC.titleColor = kAppTitleColor
            alertVC.separatorColor = kSeparatorColor
            alertVC.confirmTitleColor = UIColor(hexString: "fc672a")
            
            if vc is UINavigationController {
                (vc as! UINavigationController).viewControllers.last?.present(alertVC, animated: true, completion: nil)
            }
            else{
                vc.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    class func showTipCancelabel(withMessage message: String, confrimAction: (() -> Void)?) {
        
        if let vc = currentViewController {
            let alertVC = QSAlertController(title: nil, message: message, preferredStyle: .alert)
            var action = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                confrimAction?()
            })
            alertVC.addAction(action)
            
            action = UIAlertAction(title: "取消", style: .cancel, handler:nil)
            alertVC.addAction(action)
            
            alertVC.titleColor = kAppTitleColor
            alertVC.separatorColor = kSeparatorColor
            alertVC.cancelTitleColor = UIColor(hexString: "fc672a")
            alertVC.confirmTitleColor = UIColor(hexString: "1daf08")
            vc.present(alertVC, animated: true, completion: nil)
        }
    }
    
    class func showTip(withMessage message: String) {
        
        showTip(withMessage: message, dismiss: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: 有关时间
    
    class func curTimeString() -> String {
        return Helper.dateStringWithFormatter(Date())
    }
    
    class func curTimestamp() -> String{
        return "\(Int(Date().timeIntervalSince1970))"
    }
    
    class func curTimestampMillisecond() -> String{
        return "\(Int(Date().timeIntervalSince1970 * 1000))"
    }
    
    class func curDateString() -> String{
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormat.string(from: date)
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
    
    class func dateFromString(_ dateString: String) -> Date?{
        return dateFromString(dateString, format: "yyyy-MM-dd HH:mm:ss")
    }
    
    class func dateFromString(_ dateString: String, format: String) -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: dateString)
    }
    
    // 两个时间时间的间隔  单位: 小时
    class func periodsOfdate1(_ date1: Date, date2: Date) -> Int {
        let time = date1.timeIntervalSince(date2)
        let hour = time/3600
        if hour < 0 {
            return Int(hour) * -1
        }
        return Int(hour)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: 文件相关
    
    // 用户文件路径
    class func userDocumentDir() -> String{
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
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
                appPrint("Could not remove dir at path \(path) \n error: \(error)")
            }
        }
    }
    
    class func fileExists(_ filePath: String) -> Bool {
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    class func removeFileWithFilePath(_ filePath:String) {
        do {
            try FileManager.default.removeItem(atPath: filePath)
        }
        catch {
            appPrint("文件删除失败:\(filePath)")
        }
    }
    
    
    class func sliceAddress(_ address: String?) -> NSDictionary? {
        guard address != nil else {
            return nil
        }
        
        let dict = NSMutableDictionary()
        
        var addStr = address! as NSString
        
        var range = addStr.range(of: "省")
        
        if range.length > 0 {
            dict["province"] = addStr.substring(to: range.location + range.length)
            addStr = addStr.substring(from: range.location + range.length) as NSString
        }
        
        range = addStr.range(of: "市")
        if range.length > 0 {
            dict["city"] = addStr.substring(to: range.location + range.length)
            addStr = addStr.substring(from: range.location + range.length) as NSString
        }
        
        range = addStr.range(of: "县")
        if range.length > 0 {
            dict["county"] = addStr.substring(to: range.location + range.length)
            addStr = addStr.substring(from: range.location + range.length) as NSString
        }
        
        range = addStr.range(of: "区")
        if range.length > 0 {
            dict["region"] = addStr.substring(to: range.location + range.length)
            addStr = addStr.substring(from: range.location + range.length) as NSString
        }
        
        dict["other"] = addStr
        
        return dict
    }
    
    class func addressFromDict(_ dict: NSDictionary?) -> String{
        var address = ""
        if dict != nil {
            var pro = dict!["province"] as? String
            pro = pro == nil ? "" : pro
            
            var city = dict!["city"] as? String
            city = city == nil ? "" : city
            
            var county = dict!["county"] as? String
            county = county == nil ? "" : county
            
            var region = dict!["region"] as? String
            region = region == nil ? "" : region
            
            address = pro! + " " + city! + " " + county! + " " + region!
            return address
        }
        
        return address
    }
    
    class func imageWithName(_ name: String) -> UIImage {
        let bundle = Bundle.main
        let path = bundle.path(forResource: name, ofType: "")
        return UIImage(contentsOfFile: path!)!
    }
    
    
    
    
    
    // MARK: 其他
    
    class func uuid() -> String{
        return UUID().uuidString
    }
    
    // 拨打电话
    class func callPhone(phoneNumber: String?) {
        
        guard phoneNumber != nil else {
            return
        }
        let str = String(format: "telprompt://%@", phoneNumber!)
        UIApplication.shared.openURL(URL(string: str)!)
    }
    
    
    
    
    
    // 待优化
    // 导航
    class func locate(address: String?) {
        
        if let address = address {
            
            appPrint(address)
            
            //warning: 暂时只支持北京的   需要优化处理
            
            var newAddress = ""
            let str = address as NSString
            if str.range(of: "北京市").location == 0 {
                newAddress = str.substring(from: 3)
            }
            else if str.range(of: "北京").location == 0 {
                newAddress = str.substring(from: 2)
            }
            else{
                newAddress = address
            }
//            
//            if newAddress.contains("号楼") {
//                let str = newAddress as NSString
//                let location = str.range(of: "号楼").location
//                if location > 0 {
//                    newAddress = str.substring(to: location + 2)
//                }
//            }
//            
            
            let vc = MapViewController()
            vc.address = newAddress
            vc.city = "北京市"
            currentViewController?.pushVC(vc)
        }
    }
    
}
