//
//  SelectPhotoView.swift
//  FSInstaller
//
//  Created by Apple on 16/9/13.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import SDWebImage

class SelectPhotoView: UIView {
    
    let scrollView = UIScrollView()
    let addButton = UIButton()
    
    lazy var paddingLeft: CGFloat = 10
    lazy var spacing: CGFloat = 3
    lazy var deleteButtonWH: CGFloat = 20
    
    lazy var placeHolderImage = UIImage(named: "load")
    
    lazy var addButtonPadding: CGFloat = 6
    lazy var photoBrowserEnabel = true
    var deleteAbleIndex = -1 {
        didSet{
            didSetImages()
        }
    }
    
    private lazy var preNetImageUrls = [String]()
    
    var didClickAddButton = {
        (selectPhotoView: SelectPhotoView) -> () in return
    }
    
    var didClickImage = {
        (selectPhotoView: SelectPhotoView, index: Int) -> Void in return
    }
    
    var didDeleteImage = {
        (index: Int) -> Void in return
    }
    
    lazy var images = [UIImage]()
    
    fileprivate lazy var imgViews = [UIImageView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    fileprivate func setup(){
        
        self.addSubview(scrollView)
        
        addButton.setImage(UIImage(named: "upload-photos"), for: UIControlState())
        self.scrollView.addSubview(addButton)
        
        addButton.addTapWithHandle { [weak self](tap) in
            self?.didClickAddButton(self!)
        }
    }
    
    override func layoutSubviews() {
        scrollView.frame = self.bounds
        
        var x: CGFloat = paddingLeft
        let wh = self.sizeHeight
        let y: CGFloat = 0
        
        let preNetImageCount = preNetImageUrls.count
        if images.count + preNetImageCount > 0 {
            
            for i in 0 ..< images.count + preNetImageCount {
                let imgView = imgViews[i]
                imgView.frame = CGRect(x: x, y: y, width: wh, height: wh)
                x += wh + spacing
                
                let delImgView = imgView.viewWithTag(9999)
                delImgView?.frame = CGRect(x: wh - spacing - deleteButtonWH, y: spacing, width: deleteButtonWH, height: deleteButtonWH)
            }
        }
        
        addButton.frame = CGRect(x: x, y: addButtonPadding, width: wh - addButtonPadding * 2, height: wh - addButtonPadding * 2)
        
        x = addButton.frame.maxX + paddingLeft
        if x < self.sizeWidth {
            x = self.sizeWidth + spacing
        }
        scrollView.contentSize = CGSize(width: x, height: self.sizeHeight)
    }
    
    func addImages(imgs: [UIImage]!){
        if let imgs = imgs{
            self.images.append(contentsOf: imgs)
            didSetImages()
        }
    }
    
    fileprivate func didSetImages(){
        
        let preNetImageCount = preNetImageUrls.count
        
        // 添加 imageView
        if imgViews.count < images.count + preNetImageCount {
            
            for i in imgViews.count ..< images.count + preNetImageCount {
                let imgView = UIImageView()
                imgView.tag = i
                imgView.contentMode = .scaleAspectFill
                imgView.layer.masksToBounds = true
                imgViews.append(imgView)
                scrollView.addSubview(imgView)
                
                imgView.addTapWithHandle({ [weak self](tap) in
                    let index = tap.view!.tag
                    self?.didClickImage(self!, index)
                    
                    self?.showPhotoBrowserWithIndex(index)
                })
                
                // 添加删除按钮
                let delImgView = UIImageView()
                delImgView.image = UIImage(named: "minus")
                delImgView.tag = 9999
                
                delImgView.addTapWithHandle({ [weak self](tap: UITapGestureRecognizer) in
                    let index = tap.view!.superview!.tag - preNetImageCount
                    self?.images.remove(at: index)
                    self?.didSetImages()
                    self?.didDeleteImage(index)
                })
                
                imgView.addSubview(delImgView)
            }
        }
        
        // 显示和隐藏删除按钮
        let imgCount = imgViews.count
        if deleteAbleIndex < 0 {
            deleteAbleIndex = preNetImageCount
        }
        if imgCount > 0 {
            for i in 0 ..< imgCount {
                let imgView = imgViews[i]
                let delView = imgView.viewWithTag(9999)
                
                if i >= deleteAbleIndex {
                    delView?.isHidden = false
                }
                else{
                    delView?.isHidden = true
                }
            }
        }
        
        // 设置网路图片
        for i in 0 ..< preNetImageCount {
            let imgView = imgViews[i]
            imgView.contentMode = .scaleAspectFit
            imgView.sd_setImage(with: URL(string: preNetImageUrls[i]), placeholderImage: placeHolderImage, options: .highPriority, completed: { (image, error, type, url) in
                
                if let error = error {
                    appPrint(error)
                }
                else{
                    imgView.contentMode = .scaleAspectFill
                }
            })
        }
        
        // 设置本地图片
        for i in preNetImageCount ..< imgViews.count {
            let imgView = imgViews[i]
            if i < images.count + preNetImageCount {
                imgView.image = images[i - preNetImageCount]
                imgView.isHidden = false
            }
            else {
                imgView.isHidden = true
            }
        }
        
        layoutSubviews()
    }
    
    func addPreNetUrls(urls: [String]?) {
        if let urls = urls {
            preNetImageUrls.append(contentsOf: urls)
            didSetImages()
        }
    }
    
    // 显示图片详情  全屏的大图片
    fileprivate func showPhotoBrowserWithIndex(_ index: Int) {
          
        let phs = NSMutableArray()
        for i in 0 ..< images.count + preNetImageUrls.count {
            let photo = MJPhoto()
            photo.image = imgViews[i].image
            photo.srcImageView = imgViews[i]
            
            phs.add(photo)
        }
        
        if phs.count > 0 {
            let photoBrowser = MJPhotoBrowser()
            photoBrowser.photos = phs as [AnyObject]
            photoBrowser.currentPhotoIndex = index.uIntValue
            photoBrowser.bgColor = UIColor.black.withAlphaComponent(0.9)
            photoBrowser.show()
            
            photoBrowser.photoToolbar.showSaveButton = false
        }
    }
    
    func updateDeleteAbleIndex(){
        deleteAbleIndex = preNetImageUrls.count + images.count
    }
    
    func reset() {
        images.removeAll()
        imgViews.removeAll()
        preNetImageUrls.removeAll()
        scrollView.removeAllSubviews()
        scrollView.addSubview(addButton)
        didSetImages()
    }
}
