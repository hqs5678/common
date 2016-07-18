//
//  VCBaseCellModel.swift
//  formoney
//
//  Created by 火星人 on 15/9/16.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



// 有图标  有行为
class BaseCellModel: NSObject {
    var title:String = ""
    var tail:String?
    var iconName:String = ""
    var rowHeight:CGFloat = 44
    var isIndicator:Bool = false  //是否显示小箭头
    var businessClosure = { return }
    
    func clickAction(){
        businessClosure()
    }
}
