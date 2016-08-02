//
//  UITabBarController_Extensions.swift
//  formoney
//
//  Created by 火星人 on 15/9/20.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



extension UITabBarController{
    
    // 淡入
    func fadeInTabBarWithDuration(duration:NSTimeInterval){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        self.tabBar.alpha = 1.0
        UIView.commitAnimations()
    }
    func fadeInTabBar(){
        fadeInTabBarWithDuration(0.2)
    }
    // 淡出
    func fadeOutTabBarWithDuration(duration:NSTimeInterval){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        self.tabBar.alpha = 0.0
        UIView.commitAnimations()
    }
    func fadeOutTabBar(){
        fadeOutTabBarWithDuration(0.2)
    }
    // 推入
    func pushInTabBarWithDuration(duration:NSTimeInterval){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        var frame = self.tabBar.frame
        frame.origin.y = UIScreen.mainScreen().bounds.size.height - frame.size.height
        self.tabBar.frame = frame
        UIView.commitAnimations()
    }
    func pushInTabBar(){
        pushInTabBarWithDuration(0.2)
    }
    // 推出
    func pushOutTabBarWithDuration(duration:NSTimeInterval){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        var frame = self.tabBar.frame
        frame.origin.y = UIScreen.mainScreen().bounds.size.height
        self.tabBar.frame = frame
        UIView.commitAnimations()
    }
    func pushOutTabBar(){
        pushOutTabBarWithDuration(0.2)
    }
}