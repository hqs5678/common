//
//  TaskModel.swift
//  FSInstaller
//
//  Created by Apple on 16/8/5.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//
 
class TaskModel: BaseCellModel {

    var address = ""
    var time = ""
    var status = 0
    var desc = ""
    var contactName = ""
    var phoneNumber = ""
    
    var type = 0  // 任务类型  0: 维修   1: 安装
    
    var statusArray: NSArray!
    
}

class TaskStatusModel: NSObject {
    
    var stauts = ""
    var datetime = ""
    var remarks = ""
    var titleColor = UIColor(hexString: "4dabe0")
}
