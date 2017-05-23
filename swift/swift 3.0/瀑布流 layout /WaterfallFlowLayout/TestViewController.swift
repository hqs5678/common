//
//  TestViewController.swift
//  CollectionViewWaterfallLayoutDemo
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 Eric Cerney. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let menu = RectangleMenu.menu()
        
        menu.frame = self.view.bounds
        
        menu.backgroundColor = UIColor.groupTableViewBackground
        menu.numberOfColumn = 3
        
        let items = NSMutableArray()
        
        
        for i in 1 ... 20 {
            let item = RectangleMenuModel()
            item.title = "我的好友 \(i)"
            if i % 2 == 0 {
                item.iconImage = UIImage(named: "icon")
            }
            else {
                item.iconImage = UIImage(named: "msg")
            }
            
            item.onClickHandle = {
                (title: String) -> Void in
                print(title)
                return
            }
            
            items.add(item)
        }
        
        menu.menus = items
        
        self.view.addSubview(menu)
        
    }
    
    

}
