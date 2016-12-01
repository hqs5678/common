//
//  CusBaseCell.swift
//  formoney
//
//  Created by 火星人 on 15/9/16.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//

class BaseCell: UITableViewCell {
    
    fileprivate let padding: CGFloat = 10.0
     
    var showSeparator = true
    var imagePadding: CGFloat = 10
    var imageMarginLeft: CGFloat = 10
    
    var separatorEdgeInset = UIEdgeInsets.zero {
        didSet{
            separator.frame = CGRect(x: separatorEdgeInset.left, y: self.frame.size.height - kSeparatorHeight, width: self.frame.size.width - separatorEdgeInset.left - separatorEdgeInset.right, height: kSeparatorHeight)
        }
    }
    
    fileprivate let separator = CALayer()
    
    var model: BaseCellModel! {
        didSet{
            self.didSetModel()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    fileprivate func setup(){
        separator.backgroundColor = kSeparatorColor.cgColor
        self.layer.addSublayer(separator)
        
        self.imageView?.contentMode = .scaleAspectFill
        textLabel?.textColor = kAppTitleColor
        self.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        
        setupCellStyle()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func didSetModel(){
        self.textLabel!.text = model.title
        self.detailTextLabel?.text = model.tail
        self.imageView!.image = model.iconImage
        imageView?.contentMode = .scaleAspectFit
        self.showSeparator = model.showSeparator
        
        if model.showIndicator {
            self.accessoryType = .disclosureIndicator
        } else{
            self.accessoryType = .none
        }
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if showSeparator {
            separator.isHidden = false
            separator.frame = CGRect(x: separatorEdgeInset.left, y: self.frame.size.height - kSeparatorHeight, width: self.frame.size.width - separatorEdgeInset.left - separatorEdgeInset.right, height: kSeparatorHeight)
        }
        else{
            separator.isHidden = true
        }
        
        
        if model != nil &&  model.iconImage != nil {
            var frame = CGRect.zero
            frame.origin.x = imageMarginLeft
            frame.origin.y = imagePadding
            frame.size.height = self.frame.size.height - imagePadding * 2
            frame.size.width = self.frame.size.height - imagePadding * 2
            
            self.imageView?.frame = frame
            
            frame = self.textLabel!.frame
            frame.origin.x = imageView!.frame.maxX + 8
            self.textLabel?.frame = frame
        }
    }
    
    fileprivate func imgWH() -> CGFloat {
        return self.frame.size.height - padding * 2
    }
    
}
