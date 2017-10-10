//
//  ZPStyle.swift
//  ZPSegmentBar
//
//  Created by 管章鹏 on 17/3/9.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

public struct ZPStyle {
    
    public init() {
        
    }

    public var titleViewBackgroundColor = UIColor.purple             //titleView 的背景颜色,     默认是紫色
    public var ContentViewBackgroundColor = UIColor.gray             //contentView 的背景颜色,   默认是灰色
    
    public var titleHeight : CGFloat = 44                            //ZPTitleView 的高度,      默认是44
    public var titleFont   : UIFont  = UIFont.systemFont(ofSize: 14) //title的字体,默认14
    public var normalColor : UIColor = .white                       //文本普通颜色,              默认白色
    public var selecteColor: UIColor = .orange                     //文本选中颜色,               默认橘色
    
    public var isScrollEnabled : Bool = true //标题能否滚动
    public  var  titleMargin : CGFloat  = 20  //能滚动情况下,文字的间距
    
    public var isShowBottomLine : Bool = true //是否显示底部Line
    public   var bottomLineColor : UIColor = .orange //line颜色
    public  var bottomLineHeight : CGFloat = 2 //Line的高度
    
    
    public  var isNeedScale : Bool = true //是否需要缩放动画效果
    public  var maxScale : CGFloat = 1.2 //放大系数;
    

    public var isShowCover : Bool = false //是否显示遮盖效果
    public  var coverViewColor : UIColor = .black //遮盖颜色
    public  var coverViewHeight : CGFloat = 25 //遮盖高度
    public  var coverViewRadius : CGFloat = 12 //遮盖圆角
    public var coverViewAlpha : CGFloat  = 0.7 //遮盖透明度
    public  var coverViewMargin : CGFloat = 8 //遮盖间距
    
    public var isTitleIntop : Bool = true //标题是否在顶部
    public var pageControlHeight : CGFloat = 20 // pageControl 的高度
    
    
}
