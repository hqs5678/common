//
//  AppDelegate.swift
//  FSInstaller
//
//  Created by Apple on 16/8/1.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

let UMAPPKEY = "57a970b1e0f55acb4a004036"

let HOMEURL = "http://www.7x24home.com"

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, BMKGeneralDelegate {

    var window: UIWindow?

    var mapManager: BMKMapManager!
    var mainVC: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        // 新用户引导页
        if Helper.valueForKeyFromUserDefaults("first") == nil {
            mainVC = window?.rootViewController
            window?.rootViewController = ControllerHelper.controllerFromStoryBoardWithIdentifier("WelcomeViewController")
            window?.makeKeyAndVisible()
            Helper.saveToUserDefaults(true as AnyObject?, key: "first")
        }
    
        // 百度地图
        initBaiduMap()

        // 初始化友盟  分享  统计等
        initUMeng()


        //getDeviceId()
        
        return true
    }
    
    private func getDeviceId(){
        // 获取umeng测试设备中deviceID
        appPrint("------")
        let str = UmengUtil.getDeviceId()
        appPrint(str!)
    }
    
    fileprivate func initBaiduMap(){
        // 百度地图
        mapManager = BMKMapManager()
        let ok = mapManager.start("Dypa8BNVa7nPTFLUEuQA8dpfrqLCcqeg", generalDelegate: self)
        if ok {
            appPrint("百度地图初始化  成功")
        }
        else{
            appPrint("百度地图初始化  失败")
        }
        
    }
    
    fileprivate func initUMeng() {
//        // 友盟分享
//        UMSocialData.setAppKey(UMAPPKEY)
//        
//        // 分享 qq
//        UMSocialQQHandler.setQQWithAppId("1105529743", appKey: "6bpIRmg4psCVLCg4", url: HOMEURL)
//        
//        // 分享 新浪
//        UMSocialSinaSSOHandler.openNewSinaSSO(withAppKey: "2452674475", secret: "2abd9143b9372b5a9dbcbde48e76f1db", redirectURL: "http://sns.whalecloud.com/sina2/callback")
//        
//        // 分享 微信
//        UMSocialWechatHandler.setWXAppId("wx6bafe2485d18dbcf", appSecret: "c1d9aa76f4618ee6ea737777b6e7c60e", url: "")
//        
//        // 分享 支付宝
//        UMSocialAlipayShareHandler.setAlipayShareAppId("2016080901725007")
        
        // 友盟统计
        //MobClick.setLogEnabled(true)
        MobClick.setLogEnabled(false)
        MobClick.setCrashReportEnabled(true)
        let config = UMAnalyticsConfig.init()
        //config.channelId = "App Store" // App Store 为默认值  可以不用设置
        config.appKey = UMAPPKEY
        MobClick.start(withConfigure: config)
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        MobClick.setAppVersion(version as! String!)
        
        // 用户登录成功后 使用自有用户进行统计
        // 模拟统计
        
        let userId = User.shared.uid
        if userId != "this_is_initial_user_id" {
            MobClick.profileSignIn(withPUID: userId)
        }
        else{
            MobClick.profileSignIn(withPUID: Helper.uuid())
        }
    }
    
    func onGetNetworkState(_ iError: Int32) {
        if (0 == iError) {
            appPrint("联网成功");
        }
        else{
            appPrint("联网失败，错误代码：Error\(iError)");
        }
    }
    
    func onGetPermissionState(_ iError: Int32) {
        if (0 == iError) {
            appPrint("授权成功");
        }
        else{
            appPrint("授权失败，错误代码：Error\(iError)");
        }
    }
//    
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        let result = UMSocialSnsService.handleOpen(url)
//        
//        if result == false {
//            //调用其他SDK，例如支付宝SDK等  
//            
//            
//        }
//        
//        return result
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        // 友盟账号统计 账号退出
        MobClick.profileSignOff()
    }


}

