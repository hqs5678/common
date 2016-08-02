//
//  CusBaseCell.swift
//  formoney
//
//  Created by 火星人 on 15/9/16.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//


class BaseCell: UITableViewCell {
    
    private let padding: CGFloat = 10.0
     
    var showSeparator = true
    
    var separatorEdgeInset = UIEdgeInsetsZero
    var separatorHeight: CGFloat = 0.4
    var separatorColor = UIColor.groupTableViewBackgroundColor()
    
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
       
        self.layer.addSublayer(separator)
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func didSetModel(){
        self.textLabel!.text = model.title
        self.detailTextLabel?.text = model.tail
        self.imageView!.image = model.iconImage
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
            separator.frame = CGRectMake(separatorEdgeInset.left, self.frame.size.height - separatorHeight, self.frame.size.width - separatorEdgeInset.left + separatorEdgeInset.right, separatorHeight)
            separator.backgroundColor = separatorColor.CGColor
        }
        else{
            separator.hidden = true
        }
        
    }
    
    private func imgWH() -> CGFloat {
        return self.frame.size.height - padding * 2
    }
    
}
