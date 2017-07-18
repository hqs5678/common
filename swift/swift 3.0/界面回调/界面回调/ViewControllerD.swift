//
//  ViewControllerD.swift
//  界面回调
//
//  Created by 火星人 on 2017/7/18.
//  Copyright © 2017年 火星人. All rights reserved.
//

import UIKit

class ViewControllerD: UIViewController {
    
    var completeHandle: ((_ result: String) -> Void)?
    
    var param = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "D"
    }
 
    @IBAction func comAction(_ sender: Any) {
        
         completeHandle?("reuslt from c \(param)")
        
    }

}
