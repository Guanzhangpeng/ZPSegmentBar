//
//  ZPPageBarView.swift
//  ZPSegmentBar
//
//  Created by 管章鹏 on 17/3/27.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

public protocol ZPPageBarViewDataSource : class {
    
   func numberOfSections(in pageBarView: ZPPageBarView) -> Int
    
   func pageBarView(_ pageBarView: ZPPageBarView, numberOfItemsInSection section: Int) -> Int
    
   func pageBarView(_ pageBarView: ZPPageBarView, collectionView : UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

public extension ZPPageBarView {
    func registerCell(_ cell : AnyClass?, reusableIdentifier : String) {
        collectionView.register(cell, forCellWithReuseIdentifier: reusableIdentifier)
    }
    
    func registerNib(_ nib : UINib?, reusableIdentifier : String) {
        collectionView.register(nib, forCellWithReuseIdentifier: reusableIdentifier)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
public class ZPPageBarView: UIView {

   public  weak var dataSource :ZPPageBarViewDataSource?
    fileprivate lazy var currentIndex : IndexPath = IndexPath(item: 0, section: 0)
    fileprivate var titles : [String]
    fileprivate var style : ZPStyle
    fileprivate var layout : ZPPageBarLayout
    
    fileprivate var titleView : ZPTitleView!
    fileprivate var collectionView : UICollectionView!
    fileprivate var pageControll   : UIPageControl!

    public init(frame:CGRect , titles : [String] , style:ZPStyle ,layout : ZPPageBarLayout) {
        self.titles=titles
        self.style=style
        self.layout=layout
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK -UI布局
extension ZPPageBarView
{
    
    fileprivate func setupUI()
    {
        //1.0 创建TitleView
        let titleY = style.isTitleIntop ? 0 : (bounds.height - style.titleHeight)
        let titleViewFrame = CGRect(x: 0, y: titleY, width: bounds.width, height: style.titleHeight)
        let titleView = ZPTitleView(frame: titleViewFrame, titles: titles, style: style)
        titleView.delegate = self
        addSubview(titleView)
        titleView.backgroundColor =  UIColor.gray
        
        self.titleView=titleView
        
        //2.0 创建CollectionView
        let collectionY = style.isTitleIntop ? style.titleHeight : 0
        let collectionH = bounds.height - style.titleHeight - style.pageControlHeight
        let collectionFrame = CGRect(x: 0, y: collectionY, width: bounds.width, height: collectionH)
        
        let collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
       
        collectionView.isPagingEnabled=true
        collectionView.showsHorizontalScrollIndicator=false
        collectionView.showsVerticalScrollIndicator=false
        collectionView.dataSource=self
        collectionView.delegate = self
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.purple
        self.collectionView = collectionView
        
        //3.0 创建UIPageControl
        let pageControllFrame = CGRect(x: 0, y: collectionFrame.maxY, width: bounds.width, height: style.pageControlHeight)
        let pageControll = UIPageControl(frame: pageControllFrame)
        
        pageControll.backgroundColor=UIColor.gray
        addSubview(pageControll)
        
        self.pageControll=pageControll
        
    }
}


//MARK -UICollectionViewDataSource:代理方法
extension ZPPageBarView : UICollectionViewDataSource
{
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(in: self) ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let itemsCount = dataSource?.pageBarView(self, numberOfItemsInSection: section) ?? 0
        
        if section == 0 {
            pageControll.numberOfPages = (itemsCount - 1) / (layout.columns * layout.rows) + 1
        }
        
        
        return itemsCount
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       return (dataSource?.pageBarView(self, collectionView: collectionView, cellForItemAt: indexPath))!
    }
}

//MARK -UICollectionViewDelegate代理方法
extension ZPPageBarView : UICollectionViewDelegate
{
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewEndScroll()
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewEndScroll()
        }
    }
    
    func scrollViewEndScroll() {
        
        //1.0 获取停止滚动位置的indexPath
        let point = CGPoint(x: collectionView.contentOffset.x + layout.sectionInset.left + 1, y: layout.sectionInset.top + 1)
        
        guard let indexPath = collectionView.indexPathForItem(at: point) else {return}
        
        //如果停止滚动时候的section不是当前Section
        if indexPath.section != currentIndex.section {
            
            //获取当前indexPath的item个数,计算pageControl的页数
            let itemCount = dataSource?.pageBarView(self, numberOfItemsInSection: indexPath.section) ?? 0
            
            pageControll.numberOfPages = (itemCount - 1) / ( layout.columns * layout.rows) + 1
            
            //改变titleView的变化
            titleView.setCurrentIndex(indexPath.section)
            
            //记录最新的indexPath
            currentIndex = indexPath
        }
        
        pageControll.currentPage = (indexPath.item) / (layout.columns * layout.rows)
        
    }
}

//MARK -ZPTitleViewDelegate:代理方法
extension ZPPageBarView : ZPTitleViewDelegate
{
 
    func titleView(_ titleView: ZPTitleView, targetIndex: Int) {
        
        // 根据targetIndex 创建对应的indexPath
        let indexPath = IndexPath(item: 0, section: targetIndex)
        
        // 滚动到对应的位置上
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
        // 设置UIPageControl的相关属性;
        let itemsInSection = dataSource?.pageBarView(self, numberOfItemsInSection: targetIndex) ?? 0
        
        pageControll.numberOfPages = (itemsInSection - 1 ) / (layout.columns * layout.rows) + 1
        
        
        pageControll.currentPage = 0
        
        //如果是最后一组并且只有一页的时候
        let sectionNum = dataSource?.numberOfSections(in: self) ?? 0
        if targetIndex == sectionNum-1 && itemsInSection <= layout.columns * layout.rows {
            return
        }
           collectionView.contentOffset.x -= layout.sectionInset.left
        
    }
}
