//
//  TaskCell.swift
//  FSInstaller
//
//  Created by Apple on 16/8/2.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


class TaskCell: UITableViewCell {
    
    var addressLabel = UILabel()
    var timeLabel = UILabel()
    
    //两个垂直的分割线
    fileprivate let imgVerticalSeparator = UIImageView()
    fileprivate let imgVerticalSeparator2 = UIImageView()
    
    fileprivate let paddingLeft: CGFloat = 10
    fileprivate let imgWH: CGFloat = 40
    
    var taskModel: TaskModel! {
        didSet{
            self.didSetTaskModel()
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
        // 设置label 字体 颜色
        textLabel?.textColor = UIColor(hexString: "5ec0eb")
        textLabel?.font = UIFont.systemFont(ofSize: 15)
        
        detailTextLabel?.textColor = kAppTitleColor
        detailTextLabel?.font = UIFont.systemFont(ofSize: 10)
        
        addressLabel.font = UIFont.systemFont(ofSize: 12)
        addressLabel.textColor = UIColor(hexString: "7b6d5f")
        
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        timeLabel.textColor = addressLabel.textColor
        
        self.addSubview(addressLabel)
        self.addSubview(timeLabel)
        
        //两个垂直的分割线
        imgVerticalSeparator.image = UIImage(named: "vertical_separator")
        imgVerticalSeparator2.image = UIImage(named: "vertical_separator")
        
        self.addSubview(imgVerticalSeparator)
        self.addSubview(imgVerticalSeparator2)
        
        // 设置选中背景颜色
        setupCellStyle()
        
    }
    
     

    fileprivate func didSetTaskModel(){
        self.addressLabel.text = taskModel.propertyAddr
        self.timeLabel.text = taskModel.reservationServiceTime
        self.detailTextLabel?.text = taskModel.linkMan + ": " + taskModel.linkPhone
        self.textLabel?.text = taskModel.product
        
        if taskModel.type == 0 {
            // 维修任务  橘黄色主题
            imageView?.image = UIImage(named: "iphone_orange")
            textLabel?.textColor = UIColor(hexString: "fd8424")
        }
        else{
            // 安装任务 蓝色主题
            imageView?.image = UIImage(named: "iphone_blue")
            textLabel?.textColor = UIColor(hexString: "5fc0ec")
        }
        
        self.imageView?.addTapWithHandle({ [weak self](tap) in
            
            Helper.showTipCancelabel(withMessage: "确定要给 \(self!.taskModel.linkMan) 拨打电话?", confrimAction: {
                
                Helper.callPhone(phoneNumber: self?.taskModel.linkPhone)
            })
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = 80
        // text label   描述
        var frame = textLabel!.frame
        frame.origin.x = paddingLeft
        frame.size.width = width
        frame.size.height = 30
        frame.origin.y = self.frame.size.height * 0.5 - frame.size.height
        textLabel?.frame = frame
        
        
        // timeLabel   时间
        frame.origin.y = self.frame.size.height * 0.5
        self.timeLabel.frame = frame
        
        // address label   地址
        frame.origin.x = self.textLabel!.frame.maxX + paddingLeft
        frame.size.width = self.frame.size.width - frame.origin.x - imgWH - paddingLeft * 2
        frame.origin.y = textLabel!.frame.origin.y
        self.addressLabel.frame = frame
        
        
        // detail label   联系人
        frame.origin.y = timeLabel.frame.origin.y
        self.detailTextLabel!.frame = frame
        
        // image view
        frame.origin.x = self.frame.size.width - imgWH - paddingLeft
        frame.origin.y = (self.frame.size.height - imgWH) * 0.5
        frame.size.width = imgWH
        frame.size.height = imgWH
        imageView?.frame = frame
        
        
        // 两个 分割线
        frame.origin.x = self.addressLabel.frame.origin.x - paddingLeft * 0.5
        frame.origin.y = paddingLeft * 2
        frame.size.height = self.frame.size.height - frame.origin.y * 2
        frame.size.width = 1
        imgVerticalSeparator.frame = frame
        
        frame.origin.x = addressLabel.frame.maxX + paddingLeft * 0.5
        imgVerticalSeparator2.frame = frame
        
    }

}
