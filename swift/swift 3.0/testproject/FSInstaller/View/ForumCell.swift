//
//  ForumCell.swift
//  FSInstaller
//
//  Created by Apple on 16/8/3.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import SDWebImage

class ForumCell: UITableViewCell {
    
    let contentLabel = UILabel()
    let imageContentView = UIView()
    
    let iconWH: CGFloat = 50
    let padding: CGFloat = 10
    
    let placeholderImg = UIImage(named: "head")
    
    var model: ForumCellModel! {
        didSet{
            textLabel?.text = model.name
            detailTextLabel?.text = model.datetime
            imageView?.sd_setImage(with: URL(string: model.iconURL), placeholderImage: placeholderImg)
            contentLabel.text = model.content
            
            // image array
            
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup(){
        
        contentLabel.font = UIFont.systemFont(ofSize: kFontSizeSmall)
        contentLabel.textColor = UIColor.darkGray
        contentLabel.numberOfLines = 0
        
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(imageContentView)
        
        imageContentView.backgroundColor = UIColor.randomColor()
        
        imageView?.setRoundAppearance()
        imageView?.backgroundColor = UIColor.randomColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard model != nil else {
            return
        }
        
        // icon   imageview
        var frame = imageView!.frame
        frame.size = CGSize(width: iconWH, height: iconWH)
        frame.origin.x = padding
        frame.origin.y = padding
        imageView?.frame = frame
        
        // text label
        frame = textLabel!.frame
        frame.origin.x = padding * 2 + iconWH
        frame.origin.y = padding
        textLabel?.frame = frame
        
        // detail label
        frame = detailTextLabel!.frame
        frame.origin.x = textLabel!.frame.origin.x
        frame.origin.y = textLabel!.frame.maxY + padding
        detailTextLabel?.frame = frame
        
        // content label
        frame = contentLabel.frame
        frame.origin.x = padding
        frame.origin.y = iconWH + padding * 2
        frame.size.width = self.frame.size.width - padding * 2
        contentLabel.frame = frame
        contentLabel.sizeToFit()
        
        frame = imageContentView.frame
        frame.origin.x = padding
        frame.origin.y = contentLabel.frame.maxY + padding
        frame.size.width = self.frame.size.width -  2 * padding
        frame.size.height = 100
        imageContentView.frame = frame
        
        
    }
}
