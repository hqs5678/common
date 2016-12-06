//
//  SingleSelectViewController.swift
//  FSInstaller
//
//  Created by Apple on 2016/11/8.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class SingleSelectViewController: BaseTableViewController {

    
    lazy var didSelectedItemHandle = {
        (index: Int, dataArray: NSArray) -> () in
    }
    
    // 需要显示的字符串的key
    var textKey = ""
    var textLabelTextColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.title = "请选择"
    }
    
    override func initData() {
        showRightBarButtonWithTitle("关闭", handler: {
            [weak self] in
            self?.dismiss(animated: true, completion: nil)
        })
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = kSeparatorColor
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.tableView.register(BaseStaticCell.classForCoder(), forCellReuseIdentifier: "BaseStaticCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseStaticCell", for: indexPath)
        
        let model = data[indexPath.row] as! NSObject
        
        cell.textLabel?.text = model.value(forKey: textKey) as? String
        cell.textLabel?.font = UIFont.systemFont(ofSize: kFontSizeNormal)
        
        if let textColor  = textLabelTextColor {
            cell.textLabel?.textColor = textColor
        }
        else {
            cell.textLabel?.textColor = kAppTitleColor
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightZero
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kHeightZero
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        didSelectedItemHandle(indexPath.row, self.data)
        dismiss(animated: true, completion: nil)
    }
    
    
    

}
