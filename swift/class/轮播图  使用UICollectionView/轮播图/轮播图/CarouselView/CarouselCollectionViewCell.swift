//
//  CarouselCollectionViewCell.swift
//  轮播图
//
//  Created by 火星人 on 16/7/18.
//  Copyright © 2016年 火星人. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: CarouselCollectionViewCellModel! {
        didSet{
            self.setupModel()
        }
    }
    
    override func awakeFromNib() {
        // 测试
        self.imgView.backgroundColor = UIColor.colorRandom()
        self.titleLabel.textColor = UIColor.whiteColor()
    }
    
    private func setupModel(){
        self.titleLabel.text = self.model.title
    }
 
    
}
