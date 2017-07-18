//
//  ViewController.swift
//  测试循环引用
//
//  Created by 火星人 on 2017/7/18.
//  Copyright © 2017年 火星人. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var myView: MyView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView = MyView(action: testMethod)
        
        self.view.addSubview(myView!)
        myView?.action()
    }
    
    func testMethod() {
        self.label.text = "haha"
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

}

