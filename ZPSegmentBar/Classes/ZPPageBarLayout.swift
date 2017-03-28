//
//  ZPPageBarLayout.swift
//  ZPSegmentBar
//
//  Created by 管章鹏 on 17/3/27.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

public class ZPPageBarLayout: UICollectionViewLayout {

    public var minimumInteritemSpacing : CGFloat = 0
    public var minimumLineSpacing : CGFloat = 0
   public var rows : Int = 2
   public var columns : Int = 4
   public var sectionInset : UIEdgeInsets = UIEdgeInsets.zero
    
    
   fileprivate lazy var attributes : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
   fileprivate var totalWidth : CGFloat = 0
    
   public override init() {
     super.init()
    
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK -准备布局
extension ZPPageBarLayout
{
    override  public func prepare() {
        super.prepare()
        
        //对CollectionView进行校验
        guard  let collectionView = collectionView else {return}
        
        //获取section的个数
        let sectionCount = collectionView.numberOfSections
        
        let itemW = (collectionView.bounds.width - sectionInset.left - sectionInset.right - (CGFloat(columns)-1) * minimumInteritemSpacing) / CGFloat(columns)
        
        let itemH = (collectionView.bounds.height - sectionInset.top - sectionInset.bottom - (CGFloat(rows)-1) * minimumLineSpacing) / CGFloat(rows)
        
        var previousNumofPage = 0 //之前页码
        //遍历section
        for section in 0..<sectionCount {
            
            //获取每组中有多少个items
            let items = collectionView.numberOfItems(inSection: section)
            
            //遍历items
            for item in 0..<items
            {
                //创建indexPath
                let indexPath = IndexPath(item: item, section: section)
                
                //创建UICollectionViewLayoutAttributes
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                //计算item处于当前Section的页码;
                let currentPage = item / (rows * columns)
                
                
                //计算item处于当前页面的索引值
                let currentIndex = item % (rows * columns)
                

                
                let itemX : CGFloat = CGFloat(previousNumofPage + currentPage) * collectionView.bounds.width + sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(currentIndex % columns)
                
                let itemY = sectionInset.top + (itemH + minimumLineSpacing) * CGFloat(currentIndex / columns)
                
                attribute.frame=CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                
                
                attributes.append(attribute)
                
            }
            
            previousNumofPage += (items - 1) / ( rows * columns ) + 1
            
        }
        
        totalWidth = CGFloat(previousNumofPage) * collectionView.bounds.width
        
        
        
    }
    
}
//MARK - 将准备好的布局返回给系统
extension ZPPageBarLayout
{
    override  public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}
//MARK -告诉系统滚动范围
extension ZPPageBarLayout
{
    override  public var collectionViewContentSize: CGSize
    {
        
        return CGSize(width: totalWidth, height: 0)
    }
}

