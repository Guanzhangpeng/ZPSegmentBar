//
//  ViewController.swift
//  ZPSegmentBar
//
//  Created by gzp on 03/09/2017.
//  Copyright (c) 2017 gzp. All rights reserved.
//

import UIKit


import ZPSegmentBar


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets=false

        let frame=CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        let titles = ["推荐321","热点3","直播6666","视频","阳光视频","社会热点","娱乐","科技","汽车"]

        var style = ZPStyle()
        style.isShowCover = true    //显示遮盖
        style.isShowBottomLine=true //显示BottomLine
        style.isNeedScale=true      //文字缩放
        
        var childVcs = [UIViewController]()
        for _ in titles {
            let vc = UIViewController()
            vc.view.backgroundColor=UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
            childVcs.append(vc)
        }
        
        //创建ZPSegmentBarView
        let segmentView = ZPSegmentBarView(frame: frame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        
        view.addSubview(segmentView)
    }


}

