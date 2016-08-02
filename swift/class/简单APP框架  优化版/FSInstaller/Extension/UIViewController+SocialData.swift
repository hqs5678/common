//
//  UIViewController+SocialData.swift
//  formoney
//
//  Created by 火星人 on 16/4/17.
//  Copyright © 2016年 hqs. All rights reserved.
//

//extension UIViewController: UMSocialUIDelegate{
//
//
//    func umengShare(){
//        UMSocialSnsService.presentSnsIconSheetView(self, appKey: UMAPPKEY, shareText: "分钱乐，一个可以赚钱的APP！信不信由你！", shareImage: UIImage(named: "AppIcon"), shareToSnsNames: [UMShareToWechatTimeline, UMShareToQzone, UMShareToSina, UMShareToWechatSession, UMShareToQQ], delegate: self)
//    }
//    func umengShare(ad: ADModel){
//        UMSocialSnsService.presentSnsIconSheetView(self, appKey: UMAPPKEY, shareText: "\(ad.title) URL: \(ad.url) (来自 分钱乐 轻松赚钱APP)", shareImage: UIImage(named: "AppIcon"), shareToSnsNames: [UMShareToWechatTimeline, UMShareToQzone, UMShareToSina, UMShareToWechatSession, UMShareToQQ], delegate: self)
//    }
//    
//    func umengShare(ad: ADModel, shareTo: NSArray){
//        UMSocialSnsService.presentSnsIconSheetView(self, appKey: UMAPPKEY, shareText: "\(ad.title) URL: \(ad.url) (来自 分钱乐 轻松赚钱APP)", shareImage: UIImage(named: "AppIcon"), shareToSnsNames: shareTo as [AnyObject], delegate: self)
//    }
//    
//    func umengShareAPP(url: String, code: String){
//        let txt = "邀请码：\(code),  快来和我一块赚钱吧！随时提现，方便快捷！新用户注册成功后还有100金币的奖励哟！分钱乐，一个可以赚钱的APP（\(url)）"
//        UMSocialSnsService.presentSnsIconSheetView(self, appKey: UMAPPKEY, shareText: txt, shareImage: UIImage(named: "AppIcon"), shareToSnsNames: [UMShareToWechatTimeline, UMShareToQzone, UMShareToSina, UMShareToWechatSession, UMShareToQQ], delegate: self)
//    }
//    
//    // umeng share
//    
//    public func closeOauthWebViewController(navigationCtroller: UINavigationController!, socialControllerService: UMSocialControllerService!) -> Bool {
//        
//        print("closeOauthWebViewController")
//        return true
//    }
//    
//    
//    public func didCloseUIViewController(fromViewControllerType: UMSViewControllerType) {
//        
//        print("didCloseUIViewController")
//    }
//    
//    public func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
//        
//        print("didFinishGetUMSocialDataInViewController")
//        print(response)
//        if response.responseCode == UMSResponseCodeSuccess {
//            
//            let platform = (response.data as NSDictionary).allKeys.first as! String
//            self.didSharedSuccessful(platform)
//            print("分享成功")
//        }
//        else{
//            print("分享失败")
//        }
//        print("-------------------------------------")
//    }
//    
//    public func didSelectSocialPlatform(platformName: String!, withSocialData socialData: UMSocialData!) {
//        
//        print("didSelectSocialPlatform")
//        print("platformName: "+platformName)
//        print("-------------------------------------")
//    }
//    
//    
//    public func isDirectShareInIconActionSheet() -> Bool {
//        return false
//    }
//    
//    
//    func didSharedSuccessful(platform: String){
//    
//    }
//}
