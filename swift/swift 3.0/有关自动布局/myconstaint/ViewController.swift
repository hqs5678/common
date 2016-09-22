//
//  ViewController.swift
//  myconstaint
//
//  Created by Apple on 16/9/22.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var box = UIView()

    @IBOutlet weak var middleView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.box.frame = CGRect(x: 0, y: 0, width: 20, height: 100)
        box.backgroundColor = UIColor.brown
        self.view.addSubview(box)
        
//    centerInParent()
        self.centerWithInsets()
    }
    
    private func centerInParent(){
        
//        box.centerInSuperview()
        
        box.centerInView(view: middleView)
        
    }
    
    private func centerWithInsets(){
        
//        box.layoutInSuperview(10, 20, 40, 80)
        
        box.layoutInView(view: self.middleView, edgeInsets: UIEdgeInsetsMake(10, 20, 40, 80))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
       

    }
 
}

