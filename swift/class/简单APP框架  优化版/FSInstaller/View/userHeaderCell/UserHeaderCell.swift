//
//  UserHeaderCell.swift
//  FSInstaller
//
//  Created by Apple on 16/8/1.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class UserHeaderCell: UITableViewCell {

    fileprivate var bgImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak fileprivate var imgView: UIImageView!
    @IBOutlet weak fileprivate var disclosureIndicatorImageView: UIImageView!
    
    var user: User! {
        didSet{
            nameLabel.text = user.userName
            imgView.image = UIImage.init(contentsOfFile: user.avatar)
            bgImgView.image = UIImage.init(contentsOfFile: user.avatar)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let borderColor = UIColor.RGB(250, g: 181, b: 79)
        
        let bgColor = UIColor.RGB(255, g: 152, b: 1)
        
        nameLabel.text = "莫甘娜"
        nameLabel.textColor = UIColor.white
        self.imgView.setRoundAppearance(borderColor, borderWidth: 4)
        imgView.image = UIImage(named: "head")
        
        bgImgView = UIImageView(frame: self.bounds)
        bgImgView.image = UIImage(named: "head")
        bgImgView.alpha = 0.1
        self.insertSubview(bgImgView, at: 0)
        bgImgView.contentMode = .scaleAspectFill
        
        let view = UIView(frame: self.bounds)
        view.backgroundColor = bgColor
        self.insertSubview(view, at: 0)
        
        imgView.backgroundColor = UIColor.blue
        
        self.accessoryType = .none
        self.disclosureIndicatorImageView.image = UIImage(named: "indicator");
        self.disclosureIndicatorImageView.contentMode = .scaleAspectFit
        self.selectionStyle = .none
        
        self.layer.masksToBounds = true
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
