//
//  AboutUsViewController.swift
//  FSInstaller
//
//  Created by Apple on 16/9/12.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseStaticTableViewController {

    @IBOutlet weak var logoButton: UIButton!
    
    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var versionDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "关于" 
    }
    override func setup(){
        
        for label in labels {
            label.textColor = kAppTitleColor
        }
        versionDetailLabel.textColor = UIColor(hexString: "a69d90")
        versionDetailLabel.font = UIFont.systemFont(ofSize: kFontSizeNormal)
        
        logoButton.isUserInteractionEnabled = false
        logoButton.imageView?.contentMode = .scaleAspectFit
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightZero
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == self.tableView.numberOfSections - 1 {
            return 20
        }
        return kSeparatorHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return self.view.sizeWidth * 0.24 * 1.88
        }
        return kAppRowHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            self.makeToast("已是最新版本")
        }
        else if indexPath.section == 2 {
            let vc = WebViewController()
            vc.title = "功能介绍"
            vc.url = urlHelper
            self.pushVC(vc)
        }
        else if indexPath.section == 3 {
            let vc = WebViewController()
            vc.title = "帮助"
            vc.url = urlHelper
            self.pushVC(vc)
        }
        else if indexPath.section == 4 {
            // 用户反馈
            let vc = ControllerHelper.controllerFromStoryBoardWithIdentifier("UserFeedbackViewController")
            self.pushVC(vc)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var frame = CGRect(x: 0, y: 0, width: self.view.sizeWidth, height: 0)
        frame.origin.y = tableView.cellForRow(at: IndexPath(row: 0, section: 1))!.originY
        frame.size.height = kAppRowHeight * 4 + kSeparatorHeight * 4
        separatorLayer.frame = frame 
    }

}
