//
//  SelectPhotoView.swift
//  FSInstaller
//
//  Created by Apple on 16/9/13.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


class SelectPhotoView: UIView {
      
    let scrollView = UIScrollView()
    let addButton = UIButton()
    
    var paddingLeft: CGFloat = 10
    var padding: CGFloat = 3
    var deleteButtonWH: CGFloat = 20
    
    var didClickAddButton = {
        
    }
    
    var didClickImage = {
        (index: Int) -> Void in return
    }
    
    var didDeleteImage = {
        (index: Int) -> Void in return
    }
    
    var images: [UIImage]! {
        didSet{
            didSetImages()
        }
    }
    
    private let imgViews = NSMutableArray()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup(){
        
        self.addSubview(scrollView)
        
        addButton.setImage(UIImage(named: "upload-photos"), forState: .Normal)
        self.scrollView.addSubview(addButton)
        
        addButton.addTapWithHandle { [weak self](tap) in
            self?.didClickAddButton()
        }
    }
    
    override func layoutSubviews() {
        scrollView.frame = self.bounds
        
        var x: CGFloat = paddingLeft
        let wh = self.sizeHeight
        let y: CGFloat = 0
        
        if images != nil {
            if images.count > 0 {
                
                for i in 0 ..< images.count {
                    let imgView = imgViews.objectAtIndex(i) as! UIImageView
                    imgView.frame = CGRectMake(x, y, wh, wh)
                    x += wh + padding
                    
                    let delImgView = imgView.viewWithTag(9999)
                    delImgView?.frame = CGRectMake(wh - padding - deleteButtonWH, padding, deleteButtonWH, deleteButtonWH)
                }
            }
        }
        
        addButton.frame = CGRectMake(x, y, wh, wh)
        
        x = CGRectGetMaxX(addButton.frame) + paddingLeft
        if x < self.sizeWidth {
            x = self.sizeWidth + padding
        }
        scrollView.contentSize = CGSizeMake(x, self.sizeHeight)
    }
    
    
    private func didSetImages(){
        
        if imgViews.count < images.count {
            
            for i in imgViews.count ... images.count {
                let view = UIImageView()
                view.tag = i
                imgViews.addObject(view)
                let delImgView = UIImageView()
                delImgView.image = UIImage(named: "minus")
                delImgView.tag = 9999
                
                view.addTapWithHandle({ [weak self](tap) in
                    let index = tap.view!.tag
                    self?.didClickImage(index)
                })
                
                delImgView.addTapWithHandle({ [weak self](tap: UITapGestureRecognizer) in
                    let index = tap.view!.superview!.tag
                    self?.images.removeAtIndex(index)
                    self?.didSetImages()
                    self?.didDeleteImage(index)
                })
                
                view.addSubview(delImgView)
                scrollView.addSubview(view)
            }
        }
        
        for i in 0 ..< imgViews.count {
            let imgView = imgViews.objectAtIndex(i) as! UIImageView
            if i < images.count {
                imgView.image = images[i]
                imgView.hidden = false
            }
            else {
                imgView.hidden = true
            }
        }
        
        layoutSubviews()
    }
}