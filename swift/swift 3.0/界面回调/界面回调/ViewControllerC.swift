//
//  ViewControllerC.swift
//  界面回调
//
//  Created by 火星人 on 2017/7/18.
//  Copyright © 2017年 火星人. All rights reserved.
//

import UIKit

class ViewControllerC: UIViewController {
    
    var completeHandle: ((_ result: String) -> Void)?
    
    var param = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "C"
    }
    
    
    @IBAction func comAction(_ sender: Any) {
        
        let dvc = controller(vcName: "ViewControllerD") as! ViewControllerD
        
        dvc.completeHandle = {
            [weak self] (result: String) in
            
            
            self?.completeHandle?(result)
        }
        
        dvc.param = param
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }

}
