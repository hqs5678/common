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
    
    fileprivate func setup(){
        var tmpArray = NSMutableArray()
        var model = SimpleInputModel()
        model.inputType = SimpleInputType.switch
        model.isOn = true
        model.text = "消息提醒"
        model.showSeparator = false
        tmpArray.add(model)
        
        data.add(tmpArray)
        
        tmpArray = NSMutableArray()
        
        model = SimpleInputModel()
        model.inputType = SimpleInputType.switch
        model.text = "声音"
        model.isOn = true
        model.showSeparator = true
        tmpArray.add(model)
        
        model = SimpleInputModel()
        model.inputType = SimpleInputType.switch
        model.text = "震动"
        model.isOn = true
        model.showSeparator = false
        tmpArray.add(model)
        
        data.add(tmpArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
 

}
