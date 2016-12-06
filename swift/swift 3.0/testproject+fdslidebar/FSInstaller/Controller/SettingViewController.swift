//
//  SettingViewController.swift
//  FSInstaller
//
//  Created by Apple on 16/9/13.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class SettingViewController: BaseStaticTableViewController {
      
    @IBOutlet var labels: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "设置"
    }
    
    internal override func setup(){
         
        separatorLayer.frame = CGRect(x: 0, y: 30, width: self.view.sizeWidth, height: kAppRowHeight) 
        
        for label in labels {
            label.textColor = kAppTitleColor
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            // 消息设置
            
        }
        else if indexPath.section == 1 {
            // 修改密码
            
        }
        else if indexPath.section == 2 {
            // 退出登录
            UserHelper.logout()
            self.popVC()
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return kSeparatorHeight
        }
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kHeightZero
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 50
        }
        return kAppRowHeight
    }

}
