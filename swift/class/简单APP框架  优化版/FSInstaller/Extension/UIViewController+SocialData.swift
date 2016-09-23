//
//  UIViewController+SocialData.swift
//  formoney
//
//  Created by 火星人 on 16/4/17.
//  Copyright © 2016年 hqs. All rights reserved.
//

extension UIViewController: UMSocialUIDelegate{

    
    func umengShareAPP(){
        let txt = "富顺天牧app  安装工维修工版"
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: UMAPPKEY, shareText: txt, shareImage: UIImage(named: "AppIcon"), shareToSnsNames: [UMShareToWechatTimeline, UMShareToQzone, UMShareToSina, UMShareToWechatSession, UMShareToQQ, UMShareToAlipaySession], delegate: self)
    }
    
    // umeng share
    
    public func closeOauthWebViewController(_ navigationCtroller: UINavigationController!, socialControllerService: UMSocialControllerService!) -> Bool {
        
        print("closeOauthWebViewController")
        return true
    }
    
    
    public func didCloseUIViewController(_ fromViewControllerType: UMSViewControllerType) {
        
        print("didCloseUIViewController")
    }
    
    public func didFinishGetUMSocialData(inViewController response: UMSocialResponseEntity!) {
        
        print("didFinishGetUMSocialDataInViewController")
        print(response)
        if response.responseCode == UMSResponseCodeSuccess {
            
            let platform = (response.data as NSDictionary).allKeys.first as! String
            self.didSharedSuccessful(platform)
            print("分享成功")
        }
        else{
            print("分享失败")
        }
        print("-------------------------------------")
    }
    
    public func didSelectSocialPlatform(_ platformName: String!, with socialData: UMSocialData!) {
        
        print("didSelectSocialPlatform")
        print("platformName: "+platformName)
        print("-------------------------------------")
    }
    
    
    public func isDirectShareInIconActionSheet() -> Bool {
        return false
    }
    
    
    func didSharedSuccessful(_ platform: String){
    
    }
}
