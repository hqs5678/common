//
//  App.swift
//  formoney
//
//  Created by 火星人 on 15/9/22.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

class App: NSObject {
    struct Constants {
        static var appBackgroundColorAlpha:CGFloat = 0.86   // 标题的背景色的透明度
        static var groupDividerHeight:CGFloat = 17          // 界面分组之间的距离
        static var cellHeight:CGFloat = 44
        static var appMainColor:UIColor = UIColor.RGB(60, g: 57, b: 43)
//        static var appTitleColor:UIColor = UIColor.RGB(24, g: 203, b: 158)
        static var appTitleColor:UIColor = UIColor.whiteColor()
        static var appWarningColor:UIColor = UIColor(red: 0.1, green: 1, blue: 0, alpha: 1)
        static var appGreenColor:UIColor = UIColor.RGB(3, g: 166, b: 4)
        static var appItemBackgroundColor:UIColor = UIColor.RGB(187, g: 206, b: 213)
        static var appBackgroundColor:UIColor = UIColor.RGB(239, g: 239, b: 239)
        static var appGroupTableViewBackgroundColor:UIColor = UIColor.RGB(239, g: 239, b: 239)
        static var appTextFiledTintColor:UIColor = UIColor.lightGrayColor()
        static var appToastPosition:CGPoint = CGPointMake(UIScreen.mainScreen().bounds.size.width * 0.5, UIScreen.mainScreen().bounds.size.height - 100)
        static var appScreenSize:CGSize = UIScreen.mainScreen().bounds.size
        static var keyboardHight:CGFloat = -1
    }
    
}

extension App { 
    class var appBackgroundColorAlpha:CGFloat {
        get{
            return Constants.appBackgroundColorAlpha
        }
        set{
            Constants.appBackgroundColorAlpha = newValue
        }
    }
    class var groupDividerHeight:CGFloat {
        get{
            return Constants.groupDividerHeight
        }
        set{
            Constants.groupDividerHeight = newValue
        }
    }
    class var cellHeight:CGFloat {
        get{
            return Constants.cellHeight
        }
        set{
            Constants.cellHeight = newValue
        }
    }
    class var appMainColor:UIColor {
        get{
            return Constants.appMainColor
        }
        set{
            Constants.appMainColor = newValue
        }
    }
    class var appTitleColor:UIColor {
        get{
            return Constants.appTitleColor
        }
        set{
            Constants.appTitleColor = newValue
        }
    }
    class var appWarningColor:UIColor {
        get{
            return Constants.appWarningColor
        }
        set{
            Constants.appWarningColor = newValue
        }
    }
    class var appGreenColor:UIColor {
        get{
            return Constants.appGreenColor
        }
        set{
            Constants.appGreenColor = newValue
        }
    }
    class var appItemBackgroundColor:UIColor {
        get{
            return Constants.appItemBackgroundColor
        }
        set{
            Constants.appItemBackgroundColor = newValue
        }
    }
    class var appBackgroundColor:UIColor {
        get{
            return Constants.appBackgroundColor
        }
        set{
            Constants.appBackgroundColor = newValue
        }
    }
    class var appGroupTableViewBackgroundColor:UIColor {
        get{
            return Constants.appGroupTableViewBackgroundColor
        }
        set{
            Constants.appGroupTableViewBackgroundColor = newValue
        }
    }
    class var appTextFiledTintColor:UIColor {
        get{
            return Constants.appTextFiledTintColor
        }
        set{
            Constants.appTextFiledTintColor = newValue
        }
    }
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

let SCREEN_WIDTH: CGFloat = App.appScreenSize.width
let SCREEN_HEIGHT: CGFloat = App.appScreenSize.width

let kUserRole = "0"
let kDevice:Int = 0
let kApiCode:Int = 0



let kAppVersion = "V 1.0.0"

