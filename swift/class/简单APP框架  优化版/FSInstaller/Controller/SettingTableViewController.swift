//
//  SettingTableViewController.swift
//  FSInstaller
//
//  Created by Apple on 16/8/2.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class SettingTableViewController: SimpleInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "设置"
        
        setup()
    }
    
    private func setup(){
        var tmpArray = NSMutableArray()
        var model = SimpleInputModel()
        model.inputType = SimpleInputType.Switch
        model.isOn = true
        model.text = "消息提醒"
        model.showSeparator = false
        tmpArray.addObject(model)
        
        data.addObject(tmpArray)
        
        tmpArray = NSMutableArray()
        
        model = SimpleInputModel()
        model.inputType = SimpleInputType.Switch
        model.text = "声音"
        model.isOn = true
        model.showSeparator = true
        tmpArray.addObject(model)
        
        model = SimpleInputModel()
        model.inputType = SimpleInputType.Switch
        model.text = "震动"
        model.isOn = true
        model.showSeparator = false
        tmpArray.addObject(model)
        
        data.addObject(tmpArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
 

}
