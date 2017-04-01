//
//  ZPContentView.swift
//  ZPSegmentBar
//
//  Created by 管章鹏 on 17/3/9.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit


 protocol ZPContentViewDelegate : class {
   func contentView( _ contentView : ZPContentView , didEndScroll targetIndex : Int)
    
   func contentView( _ contentView : ZPContentView ,sourceIndex : Int ,targetIndex : Int ,progress : CGFloat)
}

private let kContentCellID = "kContentCellID"

class ZPContentView: UIView {
    
   // MARK : 属性
    weak var delegate :ZPContentViewDelegate?
    fileprivate lazy var startOffsetX : CGFloat = 0
    //当点击title时是否禁止ContentView的代理方法
    var isForbidDelegate : Bool = false
    var childVcs :[UIViewController]
    var parentVc : UIViewController
    fileprivate lazy var collectionView : UICollectionView = {
       
        let layout=UICollectionViewFlowLayout()
        layout.itemSize=self.bounds.size
        layout.minimumLineSpacing=0
        layout.minimumInteritemSpacing=0
        layout.scrollDirection = .horizontal
        
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)

        collectionView.showsVerticalScrollIndicator=false
        collectionView.showsHorizontalScrollIndicator=false
        collectionView.isPagingEnabled=true
        collectionView.bounces=false
        
        return collectionView
        
    }()
   

    init(frame : CGRect , childVcs :[UIViewController], parentVc:UIViewController) {
        
        self.childVcs=childVcs
        self.parentVc=parentVc
        
        super.init(frame: frame)
        
        //1.0 布局UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ZPContentView
{
    fileprivate func setupUI()
    {
       //1.0 将childVcs中的所有控制器添加到父控制器中
        for childVc in childVcs {
            
            parentVc.addChildViewController(childVc)
        }
        
        //2.0 添加UICollectionView
        addSubview(collectionView)
    }
}

//MARK -UICollectionView数据源代理方法 --UICollectionViewDataSource
extension ZPContentView : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
        
        return cell
        
    }
}
//MARK -UICollectionView代理方法 --UICollectionViewDelegate
extension ZPContentView : UICollectionViewDelegate
{

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidDelegate=false
        startOffsetX=scrollView.contentOffset.x
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDIdEndScroll()
    }
  
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate
        {
            scrollViewDIdEndScroll()
        }
    }
    
    // MARK :  停止滚动
    private func scrollViewDIdEndScroll()
    {
        
        let targetIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        
        delegate?.contentView(self, didEndScroll: targetIndex)
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetX = scrollView.contentOffset.x
        
        guard contentOffsetX != startOffsetX && !isForbidDelegate else {
            return
        }
        
        //定义需要获取的变量
        var sourceIndex = 0
        var targetIndex = 0
        var progress : CGFloat = 0
        let collectionWidth = collectionView.bounds.width
        
        //左侧滑动
        if contentOffsetX > startOffsetX  {
            sourceIndex = Int(contentOffsetX / collectionWidth)
            targetIndex = sourceIndex + 1
            
             progress = CGFloat(scrollView.contentOffset.x).truncatingRemainder(dividingBy: CGFloat(collectionWidth)) / CGFloat(collectionWidth)
            
            if((contentOffsetX - startOffsetX)==collectionWidth)
            {
                progress = 1
                targetIndex=sourceIndex
            }
        }
        else{
            //右侧滑动
            targetIndex = Int(contentOffsetX / collectionWidth)
            
            sourceIndex = targetIndex + 1
            
            progress = 1 - (CGFloat(scrollView.contentOffset.x).truncatingRemainder(dividingBy: CGFloat(collectionWidth)) / CGFloat(collectionWidth))
            
        }
        if targetIndex > childVcs.count - 1 || targetIndex < 0 || sourceIndex > childVcs.count - 1 {
            return
        }
        delegate?.contentView(self, sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
        
    }
}
//MARK -ZPTitleViewDelegate代理方法
extension ZPContentView : ZPTitleViewDelegate
{
    func titleView(_ titleView: ZPTitleView, targetIndex: Int) {
        
        isForbidDelegate = true
        
        //1.0 创建IndexPath,让CollectionView滚动到对应的位置;
        let indexPath = IndexPath(item: targetIndex, section: 0)
        
        collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
    }
}

