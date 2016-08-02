//
//  UserHeaderCell.swift
//  FSInstaller
//
//  Created by Apple on 16/8/1.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class UserHeaderCell: UITableViewCell {

    private var bgImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak private var imgView: UIImageView!
    @IBOutlet weak private var disclosureIndicatorImageView: UIImageView!
    
    var user: User! {
        didSet{
            nameLabel.text = user.userName
            imgView.image = UIImage.init(contentsOfFile: user.avatar)
            bgImgView.image = UIImage.init(contentsOfFile: user.avatar)
        }
    }
    
    private let borderColor = UIColor.RGB(250, g: 181, b: 79)
    private let bgColor = UIColor.RGB(255, g: 152, b: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = "莫甘娜"
        nameLabel.textColor = UIColor.whiteColor()
        self.imgView.setRoundAppearance(borderColor, borderWidth: 4)
        imgView.image = UIImage(named: "head")
        
        bgImgView = UIImageView(frame: self.bounds)
        bgImgView.image = UIImage(named: "head")
        bgImgView.alpha = 0.1
        self.insertSubview(bgImgView, atIndex: 0)
        bgImgView.contentMode = .ScaleAspectFill
        
        let view = UIView(frame: self.bounds)
        view.backgroundColor = bgColor
        self.insertSubview(view, atIndex: 0)
        
        imgView.backgroundColor = UIColor.blueColor()
        
        self.accessoryType = .None
        self.disclosureIndicatorImageView.image = UIImage(named: "indicator");
        self.disclosureIndicatorImageView.contentMode = .ScaleAspectFit
        self.selectionStyle = .None
        
        self.layer.masksToBounds = true
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
