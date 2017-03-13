//
//  ZPSegmentBarView.swift
//  ZPSegmentBar
//
//  Created by 管章鹏 on 17/3/9.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit


public class ZPSegmentBarView: UIView {
    
    var titles :[String]
    var style :ZPStyle
    var childVcs :[UIViewController]
    var parentVc : UIViewController
    
   public init(frame:CGRect,titles:[String],style : ZPStyle,childVcs:[UIViewController],parentVc:UIViewController ) {
        
        self.titles=titles
        self.style=style
        self.childVcs=childVcs
        self.parentVc=parentVc
        super.init(frame: frame)
        
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK - UI布局
extension ZPSegmentBarView
{
    fileprivate func setupUI()
    {
        //1.0 创建TitleView 
        let titleFrame = CGRect(x: 0, y: 64, width: bounds.width, height: style.titleHeight)
        
        let titleView = ZPTitleView(frame: titleFrame, titles: titles, style: style)
        addSubview(titleView)
        titleView.backgroundColor = UIColor.gray
        
       
        
        //2.0 创建ContentView
        let contentFrame = CGRect(x: 0, y: titleView.frame.maxY, width: bounds.width, height: bounds.height-style.titleHeight)
        
        let contentView = ZPContentView(frame: contentFrame, childVcs: childVcs, parentVc: parentVc)
        
        addSubview(contentView)
        
        // 3.0 让ContentView成为titleView的代理
        titleView.delegate = contentView
        contentView.delegate = titleView
        
        //3.0 设置TitleView和ContentView之间的关联
    }
    
}
