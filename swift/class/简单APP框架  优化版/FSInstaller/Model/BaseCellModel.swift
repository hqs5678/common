//
//  VCBaseCellModel.swift
//  formoney
//
//  Created by 火星人 on 15/9/16.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



// 有图标  有行为
class BaseCellModel: NSObject {
    var title = ""
    var detail = ""
    var tail = ""
    var iconImage: UIImage!     // image
    var rowHeight:CGFloat = 44
    var showIndicator = false   //是否显示小箭头
    var showSeparator = true
    
    var onSelected = { return }
    
    func clickAction(){
        onSelected()
    }
}
