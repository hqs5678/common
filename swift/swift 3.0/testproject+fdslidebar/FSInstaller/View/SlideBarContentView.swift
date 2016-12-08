//
//  SlideBarContentView.swift
//  FSInstaller
//
//  Created by Apple on 2016/12/8.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

class SlideBarContentView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
  
    var collectionView: UICollectionView!
    var numberOfSections = 1
     
    var collectionViewWillShowCellHandle = {
        (cell: SlideBarContentViewCell, indexPath: IndexPath) -> Void in
        return
    }
    
    var collectionViewDidShowCellHandle = {
        (cell: SlideBarContentViewCell, indexPath: IndexPath) -> Void in
        return
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    fileprivate func setup(){
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.isPagingEnabled = true
        self.addSubview(collectionView)
        
        collectionView.register(SlideBarContentViewCell.classForCoder(), forCellWithReuseIdentifier: "SlideBarContentViewCell")
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionViewWillShowCellHandle(cell as! SlideBarContentViewCell, indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideBarContentViewCell", for: indexPath) as! SlideBarContentViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: IndexPath!) -> CGSize{
        
        return self.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let indexPath = collectionView.indexPathForItem(at: scrollView.contentOffset)
        if let indexPath = indexPath {
            let cell = collectionView.cellForItem(at: indexPath) as! SlideBarContentViewCell
            self.collectionViewDidShowCellHandle(cell, indexPath)
        }
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    
}

class SlideBarContentViewCell: UICollectionViewCell {
    
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        self.tableView.frame = self.bounds
        self.addSubview(tableView)
    }
    
}
