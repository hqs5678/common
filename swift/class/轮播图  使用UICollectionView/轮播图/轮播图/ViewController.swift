//
//  ViewController.swift
//  轮播图
//
//  Created by 火星人 on 16/7/18.
//  Copyright © 2016年 火星人. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var carouselView: CarouselView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let models = NSMutableArray()
        for i in 1...5 {
            let mo = CarouselCollectionViewCellModel()
            mo.title = "\(i)"
            mo.imageName = "image-\(i)"
            models.add(mo)
        }
        
        
        self.carouselView = CarouselView.viewFromNib()
        self.carouselView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300)
        self.view.addSubview(self.carouselView)
        
        self.carouselView.models = models
        self.carouselView.didClickItemAt = {
            (index: Int) -> Void in
            print(index)
        }
    }

    @IBAction func startAnimation(_ sender: AnyObject) {
        
        self.carouselView.isAutoPlay = true
        
    }
    
    @IBAction func stopPlay(_ sender: AnyObject) {
        self.carouselView.isAutoPlay = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

