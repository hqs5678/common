//
//  ViewController.swift
//  界面回调
//
//  Created by 火星人 on 2017/7/18.
//  Copyright © 2017年 火星人. All rights reserved.
//

import UIKit

class ViewControllerA: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "A"
        self.resultLabel.numberOfLines = 0
    }

    @IBAction func nextAction(_ sender: Any) {
        
        let param = "\(Date())"
        
        let bvc = controller(vcName: "ViewControllerB") as! ViewControllerB
        bvc.completeHandle = {
            [weak self] (result: String) in
            
            self?.resultLabel.text = result
            self?.navigationController?.popToViewController(self!, animated: true)
        }
        bvc.param = param
        
        self.navigationController?.pushViewController(bvc, animated: true)
    }
    
    
    
}


func controller(vcName: String) -> UIViewController {
    
    let mainBundle = Bundle.main
    let storyBoard = UIStoryboard.init(name: "Main", bundle: mainBundle)
    return storyBoard.instantiateViewController(withIdentifier: vcName)
}

