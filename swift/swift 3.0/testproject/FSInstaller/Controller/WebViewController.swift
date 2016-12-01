//
//  WebViewController.swift
//  FSInstaller
//
//  Created by Apple on 2016/11/11.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController, UIWebViewDelegate {
    
    let webView = UIWebView()
    lazy var url = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.title == nil {
            self.title = "未设置标题"
        }
        
        self.view.addSubview(webView)
        webView.layoutInSuperview(0, 0, 0, 0)
        webView.backgroundColor = kAppBackgroundColor
        webView.delegate = self
        
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
            Helper.showProgressHUD()
        }
        else{
            appPrint("url is not ok !!!")
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        appPrint("webViewDidFinishLoad")
        Helper.hideProgressHUD()
    }
    

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        appPrint("webView didFailLoadWithError")
        appPrint(error)
        
        Helper.hideProgressHUD()
        Helper.showTip(withMessage: "加载数据错误!")
    }
     

}
