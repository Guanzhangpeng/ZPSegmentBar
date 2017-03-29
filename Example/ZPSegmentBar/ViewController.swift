//
//  ViewController.swift
//  ZPSegmentBar
//
//  Created by gzp on 03/09/2017.
//  Copyright (c) 2017 gzp. All rights reserved.
//

import UIKit
import ZPSegmentBar

private let kCollectionViewCellID = "kCollectionViewCellID"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets=false

        let frame=CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
//        
        let titles = ["推荐321","热点3","直播6666","视频","阳光视频","社会热点","娱乐","科技","汽车"]

        var style = ZPStyle()
        style.isShowBottomLine=false
//        style.isShowCover = true    //显示遮盖
//        style.isShowBottomLine=true //显示BottomLine
//        style.isNeedScale=true      //文字缩放
        
        var childVcs = [UIViewController]()
        for _ in titles {
            let vc = UIViewController()
            vc.view.backgroundColor=UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
            childVcs.append(vc)
        }
        
        //创建ZPSegmentBarView
        let segmentView = ZPSegmentBarView(frame: frame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        
        view.addSubview(segmentView)
        
        
//        let titles = ["热门", "高级", "专属", "豪华"]
//        var  style  = ZPStyle()
//        
//        style.isScrollEnabled = false
//        
//        let layout = ZPPageBarLayout()
//        
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        layout.minimumLineSpacing=10
//        layout.minimumInteritemSpacing=10
//        layout.columns=8
//        layout.rows = 3
//        
//        
//        let frame = CGRect(x: 0, y: 100, width:view.bounds.width, height: 300)
//        
//        let pageBarView = ZPPageBarView(frame: frame, titles: titles, style: style, layout: layout)
//        //设置数据源
//        pageBarView.dataSource=self
//        
//        pageBarView.registerCell(UICollectionViewCell.self, reusableIdentifier: kCollectionViewCellID)
//        
//        view.addSubview(pageBarView)
        
    }
}
extension ViewController : ZPPageBarViewDataSource
{
    func numberOfSections(in pageBarView: ZPPageBarView) -> Int {
        return 4
    }
    func pageBarView(_ pageBarView: ZPPageBarView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 61
        } else if section == 1 {
            return 18
        } else if section == 2 {
            return 40
        } else {
            return 18
        }
    }
    func pageBarView(_ pageBarView: ZPPageBarView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
}

