//
//  ViewControllerB.swift
//  界面回调
//
//  Created by 火星人 on 2017/7/18.
//  Copyright © 2017年 火星人. All rights reserved.
//

import UIKit

class ViewControllerB: UIViewController {
    
    var completeHandle: ((_ result: String) -> Void)?
    
    var param = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "B"
    }
 
    @IBAction func nextAction(_ sender: Any) {
        
        let cvc = controller(vcName: "ViewControllerC") as! ViewControllerC
        cvc.completeHandle = {
            [weak self] (result: String) in
            
            self?.completeHandle?(result)
        }
        cvc.param = param
        
        self.navigationController?.pushViewController(cvc, animated: true)
    }

}
