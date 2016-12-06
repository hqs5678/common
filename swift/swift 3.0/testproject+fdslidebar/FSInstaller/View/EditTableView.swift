//
//  EditTableView.swift
//  formoney
//
//  Created by 火星人 on 16/1/2.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


class EditTableView: UITableView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
}
