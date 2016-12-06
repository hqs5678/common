//
//  App.swift
//  formoney
//
//  Created by 火星人 on 15/9/22.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

class App: NSObject {
    struct Constants {
        static var appToastPosition:CGPoint = CGPoint(x: UIScreen.main.bounds.size.width * 0.5, y: UIScreen.main.bounds.size.height - 80)
        static var keyboardHight:CGFloat = -1
    }
    
}

extension App { 
    
    class var appToastPosition:CGPoint {
        get{
            return Constants.appToastPosition
        }
        set{
            Constants.appToastPosition = newValue
        }
    } 
    class var keyboardHight:CGFloat {
        get{
            return Constants.keyboardHight
        }
        set{
            Constants.keyboardHight = newValue
        }
    }
}

let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height

let kUserRole = "0"
let kDevice = "1"
let kApiCode = "0"
let kAppVersion = "V 1.0.0"
  

let kAppMainColor = UIColor(hexString: "fee45d")
let kTabBarColor = UIColor(hexString: "fffcee")
let kRefreshBackgroundColor = UIColor(hexString: "d5d5d5")
let kAppTitleColor = UIColor(hexString: "64543e")
let kAppTitlelLightColor = UIColor(hexString: "a08a6b")
let kPlaceHolderTextColor = UIColor(hexString: "cac4ba")
let kAppBackgroundColor = UIColor(hexString: "f7f7f7")
let kSeparatorColor = UIColor(hexString: "eae4d6")

// 选中行的颜色
let kSelectedRowBackgroundColor = UIColor(hexString: "fffbf1")
let kProgressTintColor = UIColor(hexString: "150a05")
let kAppRedColor = UIColor(hexString: "b83810")
let kAppGreenColor = UIColor(hexString: "0eb31b")
let kAppOrangeColor = UIColor(hexString: "e9a407") 
let kButtonNormalColor = UIColor(hexString: "c4db4c")
let kButtonRedColor = UIColor(hexString: "e9a407")

// 界面分组之间的距离
let kGroupDividerHeight:CGFloat = 20
let kSeparatorHeight: CGFloat = 0.5
let kAppRowHeight: CGFloat = 55
let kCornerRadius: CGFloat = 4
let kHeightZero: CGFloat = 0.000001


let kFontSizeNormal:CGFloat = 14
let kFontSizeSmall: CGFloat = 12
let kFontSizeBig: CGFloat = 17
  
let kIOS7 = Double(UIDevice().systemVersion)!>=7.0 ? 1 :0
let kIOS8 = Double(UIDevice().systemVersion)!>=8.0 ? 1 :0


// MARK: 有关线程
// MARK: 延迟一段时间后再主线程中执行
public func doInMainThreadAfter(_ delay:Double, task:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: task)
}

func doInMainThread(_ task: @escaping (() -> Void)){
    DispatchQueue.main.async(execute: task)
}

func doInBackground(_ task:@escaping (() -> Void), completion:(() -> Void)?){
    
    DispatchQueue.global(qos: .background).async { () -> Void in
        task()
        guard completion != nil else {
            return
        }
        completion!()
    }
}

// MARK: 随机数
func random() -> Int{
    return arc4random().intValue
}

// 在 base navigation controller 中进行维护该值
weak var currentViewController: UIViewController?


// 日志输出  发布应用时屏蔽
func appPrint(_ items: Any...){
    
    print(items)
}




