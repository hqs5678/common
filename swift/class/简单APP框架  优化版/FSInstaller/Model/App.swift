//
//  App.swift
//  formoney
//
//  Created by 火星人 on 15/9/22.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

class App: NSObject {
    struct Constants {
        static var appToastPosition:CGPoint = CGPointMake(UIScreen.mainScreen().bounds.size.width * 0.5, UIScreen.mainScreen().bounds.size.height - 100)
        static var appScreenSize:CGSize = UIScreen.mainScreen().bounds.size
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
    class var appScreenSize:CGSize {
        get{
            return Constants.appScreenSize
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

let kGroupDividerHeight:CGFloat = 17          // 界面分组之间的距离
 

let SCREEN_WIDTH: CGFloat = App.appScreenSize.width
let SCREEN_HEIGHT: CGFloat = App.appScreenSize.width

let kAppMainColor:UIColor = UIColor.RGB(60, g: 57, b: 43)
let kAppTitleColor:UIColor = UIColor.whiteColor()
let kAppBackgroundColor:UIColor = UIColor.RGB(239, g: 239, b: 239)

let kUserRole = "0"
let kDevice:Int = 0
let kApiCode:Int = 0



let kAppVersion = "V 1.0.0"

