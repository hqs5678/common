//
//  RectangleMenu.swift
//  CollectionViewWaterfallLayoutDemo
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 Eric Cerney. All rights reserved.
//

import UIKit

class RectangleMenu: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewWaterfallLayoutDelegate {
    
    
    
    var menus: NSArray! {
        didSet{
            guard menus != nil else {
                return
            }
            reloadData()
        }
    }
    
    var numberOfColumn = 3 {
        didSet{
            updateLayout()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setup()
    }
    
    class func menu() -> RectangleMenu {
        let warterfallLayout = CollectionViewWaterfallLayout()
        return RectangleMenu(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: warterfallLayout)
    }
    
    fileprivate func setup(){
        
        self.register(RectangleMenuCell.classForCoder(), forCellWithReuseIdentifier: "RectangleMenuCell")
        self.delegate = self
        self.dataSource = self
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if self.menus == nil {
            return 0
        }
        return self.menus.count
    }

    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: 1, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RectangleMenuCell", for: indexPath) as! RectangleMenuCell
        
        cell.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        
        let model = menus[indexPath.item] as! RectangleMenuModel
        cell.model = model
        
        return cell
    }
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let model = menus[indexPath.item] as! RectangleMenuModel
        model.onClickHandle(model.title)
    }
    
   
    
    
    
    @objc fileprivate func updateLayout(){
       
        let warterfallLayout = self.collectionViewLayout as! CollectionViewWaterfallLayout
        
        warterfallLayout.columnCount = numberOfColumn
        warterfallLayout.minimumColumnSpacing = 2
        warterfallLayout.minimumInteritemSpacing = 2
        
        // 不是ContentInsets !!!!
//        warterfallLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2)
    
        
        self.reloadData()
    }
}

class RectangleMenuCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let iconView = UIImageView()
    
    var titleLabelHeight: CGFloat = 20
    
    var contentInsets = UIEdgeInsets.zero
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    var model: RectangleMenuModel! {
        didSet{
            titleLabel.text = model.title
            iconView.image = model.iconImage
        }
    }
    
    fileprivate func setup(){
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        view.backgroundColor = UIColor.groupTableViewBackground
        self.selectedBackgroundView = view
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(iconView)
        
        self.backgroundColor = UIColor.white
//        
//        titleLabel.backgroundColor = UIColor.lightGrayColor()
//        iconView.backgroundColor = UIColor.grayColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = iconView.frame
        frame.origin.x = contentInsets.left
        frame.origin.y = contentInsets.top
        
        frame.size.height = contentView.frame.size.height - contentInsets.top - contentInsets.bottom - titleLabelHeight
        frame.size.width = frame.size.height
        frame.origin.x = (contentView.frame.size.width - frame.size.width) * 0.5
        
        iconView.frame = frame
        
        frame.origin.y = iconView.frame.maxY + 2
        frame.origin.x = contentInsets.left
        frame.size.height = titleLabelHeight
        frame.size.width = contentView.frame.size.width - contentInsets.left - contentInsets.right
        
        titleLabel.frame = frame
    }
}

class RectangleMenuModel: NSObject{
    var title = ""
    var iconImage: UIImage!
    var onClickHandle = {
        (title: String) -> Void in
        
        return
    }
}
