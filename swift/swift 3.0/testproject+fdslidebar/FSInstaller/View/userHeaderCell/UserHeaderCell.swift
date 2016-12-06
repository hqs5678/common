//
//  UserHeaderCell.swift
//  FSInstaller
//
//  Created by Apple on 16/8/1.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class UserHeaderCell: UITableViewCell {
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var bgViewf: UIView!
    
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    
    var user: User! {
        didSet{
            nameLabel.text = user.userName
            
            let image = UIImage.init(contentsOfFile: user.avatar)
            imgView.image = image?.circleImage(imgView.frame.size)
            if imgView.image == nil {
                let image = UIImage(named: "avatar")
                imgView.image = image?.circleImage(imgView.frame.size)
            }
            
            leftButton.setTitle("\(user.thumbNumber)", for: UIControlState())
            rightButton.setTitle("\(user.commentNumber)", for: UIControlState())
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = "莫甘娜"
        
//        leftButton.backgroundColor = UIColor.clear
//        rightButton.backgroundColor = UIColor.clear
//        
//        leftButton.setImage(UIImage(named: "thumb-up"), for: UIControlState())
//        rightButton.setImage(UIImage(named: "comments"), for: UIControlState())
        
        
        // 暂时隐藏
        leftButton.isHidden = true
        rightButton.isHidden = true
        
        self.accessoryType = .none
        self.selectionStyle = .none
        
        self.layer.masksToBounds = false
        
        self.bgViewf.backgroundColor = kAppMainColor
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
