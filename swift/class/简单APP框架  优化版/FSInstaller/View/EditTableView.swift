//
//  EditTableView.swift
//  formoney
//
//  Created by 火星人 on 16/1/2.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


class EditTableView: UITableView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.endEditing(true)
    }
}