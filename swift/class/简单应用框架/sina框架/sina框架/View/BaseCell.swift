//
//  CusBaseCell.swift
//  formoney
//
//  Created by 火星人 on 15/9/16.
//  Copyright (c) 2015年 huangqingsong. All rights reserved.
//



class BaseCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setIconPath(iconName:String, title:String, isIndicator:Bool) {
        // set icon
        if iconName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
            let icon=UIImage(named: iconName)
            self.imageView?.image=icon
        }
        
        // set title
        self.textLabel?.text=title
        
        // set indicator
        if isIndicator {
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        else {
            self.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    func setObj(cellObj:BaseCellModel){
        setIconPath(cellObj.iconName, title: cellObj.title, isIndicator: cellObj.isIndicator)
        // 如果是带有子标题的cell
        if cellObj.isKindOfClass(CellRoundNumberCellModel){
            // 添加子菜单  -> 数字
            let number = cellObj.valueForKey("number") as! Int
            if number > 0 {
                addSubTitleRound(number)
            } 
        }
        if cellObj.tail != nil {
            self.detailTextLabel?.text = cellObj.tail
        }
    }
    
    func addSubTitleRound(subTitle:Int){
        let subTitleLabel = UILabel()
        let height = self.frame.size.height
        let width = self.frame.size.width
        let padding:CGFloat = 10.0
        let hw:CGFloat = height - padding*2
        let frame = CGRectMake(width - 56, padding, hw, hw)
        subTitleLabel.frame = frame
        
        let roundLayer = subTitleLabel.layer
        roundLayer.backgroundColor = App.appWarningColor.CGColor
        roundLayer.cornerRadius = hw * 0.5
        
        subTitleLabel.text = "\(subTitle)"
        subTitleLabel.textAlignment = NSTextAlignment.Center
        subTitleLabel.font = UIFont(name: subTitleLabel.font.fontName, size: 12)
        
        self.addSubview(subTitleLabel)
    }

}
