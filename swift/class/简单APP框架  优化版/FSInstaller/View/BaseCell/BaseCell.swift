//
//  CusBaseCell.swift
//  formoney
//
//  Created by 火星人 on 15/9/16.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

let separatorHeight: CGFloat = 0.4

class BaseCell: UITableViewCell {
    
    private let padding: CGFloat = 10.0
    private let separatorOpacity: Float = 0.3
     
    var showSeparator = true
    var imageMargin: CGFloat = 10
    var imageMarginLeft: CGFloat = 10
    
    var separatorEdgeInset = UIEdgeInsetsZero {
        didSet{
            separator.frame = CGRectMake(separatorEdgeInset.left, self.frame.size.height - separatorHeight, self.frame.size.width - separatorEdgeInset.left - separatorEdgeInset.right, separatorHeight)
        }
    }
    var separatorColor = UIColor.lightGrayColor()
    
    private let separator = CALayer()
    
    var model: BaseCellModel! {
        didSet{
            self.didSetModel()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    private func setup(){
        separator.backgroundColor = separatorColor.CGColor
        separator.opacity = separatorOpacity
        self.layer.addSublayer(separator)
        
        self.imageView?.contentMode = .ScaleAspectFill
        textLabel?.textColor = UIColor.darkGrayColor()
        self.detailTextLabel?.font = UIFont.boldSystemFontOfSize(12)
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func didSetModel(){
        self.textLabel!.text = model.title
        self.detailTextLabel?.text = model.tail
        self.imageView!.image = model.iconImage
        imageView?.contentMode = .ScaleAspectFit
        self.showSeparator = model.showSeparator
        
        if model.showIndicator {
            self.accessoryType = .DisclosureIndicator
        } else{
            self.accessoryType = .None
        }
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if showSeparator {
            separator.hidden = false
            separator.frame = CGRectMake(separatorEdgeInset.left, self.frame.size.height - separatorHeight, self.frame.size.width - separatorEdgeInset.left - separatorEdgeInset.right, separatorHeight)
        }
        else{
            separator.hidden = true
        }
        
        
        if model != nil &&  model.iconImage != nil {
            var frame = CGRectZero
            frame.origin.x = imageMarginLeft
            frame.origin.y = imageMargin
            frame.size.height = self.frame.size.height - imageMargin * 2
            frame.size.width = self.frame.size.height - imageMargin * 2
            
            self.imageView?.frame = frame
            
            frame = self.textLabel!.frame
            frame.origin.x = CGRectGetMaxX(imageView!.frame) + 8
            self.textLabel?.frame = frame
        }
    }
    
    private func imgWH() -> CGFloat {
        return self.frame.size.height - padding * 2
    }
    
}
