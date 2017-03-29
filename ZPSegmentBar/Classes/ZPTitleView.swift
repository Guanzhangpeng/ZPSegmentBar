//
//  ZPTitleView.swift
//  ZPSegmentBar
//
//  Created by 管章鹏 on 17/3/9.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

protocol ZPTitleViewDelegate : class {
    
    func  titleView(_ titleView : ZPTitleView , targetIndex : Int)
}

class ZPTitleView: UIView {

      // MARK : 属性
    weak var delegate : ZPTitleViewDelegate?
    var titles : [String]
    var style : ZPStyle
    fileprivate lazy var titleLabels :[UILabel] = [UILabel]()
    fileprivate lazy var currentIndex = 0
    fileprivate lazy var normalRGB : (CGFloat,CGFloat,CGFloat) = self.style.normalColor.getRGBValue()
    fileprivate lazy var selectedRGB : (CGFloat,CGFloat,CGFloat) = self.style.selecteColor.getRGBValue()
    fileprivate lazy var deltaRGB : (CGFloat,CGFloat,CGFloat) = {
    
        let deltaR = self.selectedRGB.0 - self.normalRGB.0
        let deltaG = self.selectedRGB.1 - self.normalRGB.1
        let deltaB = self.selectedRGB.2 - self.normalRGB.2
        
//        print("R:\(deltaR) G:\(deltaG) B:\(deltaB)")
        return (deltaR,deltaG,deltaB)
        
    }()
    fileprivate lazy var scrollView : UIScrollView = {
    
        let scrollView = UIScrollView (frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.scrollsToTop=false
        return scrollView
    }()
    
    fileprivate lazy var bottomLine : UIView = {
    
        let bottomLine = UIView()
        bottomLine.backgroundColor=self.style.bottomLineColor
        return bottomLine
    }()
    
    fileprivate lazy var coverView : UIView = {
    
        let coverView = UIView()
        coverView.backgroundColor = self.style.coverViewColor
        coverView.layer.cornerRadius = self.style.coverViewRadius
        coverView.layer.masksToBounds = true
        coverView.alpha = self.style.coverViewAlpha        
        return coverView
        
    }()
    
    init(frame: CGRect,titles :[String],style :ZPStyle) {
        
        self.titles=titles
        self.style=style
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK -设置UI界面
extension ZPTitleView
{
    fileprivate func setupUI()
    {
        
        //1.0 添加UIScrollView
        addSubview(scrollView)
        
        //2.0 初始化UILabel并且布局
        setuptitlelabes()
        
        //3.0 添加bottomLine并且布局
        if style.isShowBottomLine {
            setupBottomLine()
        }
        
        //4.0 添加CoverView并且布局
        if style.isShowCover {
            setupCoverView()
        }
        
    }
    
      // MARK : 初始化UILabel并且布局
    private func setuptitlelabes()
    {
        for (index ,value) in titles.enumerated()
        {
            let titleLabel = UILabel()
            
            //设置titlelabe的属性
            titleLabel.text=value
            titleLabel.tag = index
            titleLabel.font=style.titleFont
            titleLabel.textColor = index==0 ? style.selecteColor : style.normalColor;
            titleLabel.textAlignment = .center
            titleLabel.isUserInteractionEnabled = true
            
            //将label添加到ScrollView中
            scrollView.addSubview(titleLabel)
            
            //添加点击手势
            let gesture = UITapGestureRecognizer(target: self, action: #selector(titleClick(_:)))
            
            titleLabel.addGestureRecognizer(gesture)
            
            titleLabels.append(titleLabel)
        }
        
        //对titleLabel进行布局
        var titlelabelX :CGFloat = 0
        var titleLabelW :CGFloat = bounds.width / CGFloat(titleLabels.count)
        let titleLabelY :CGFloat = 0
        let titleLabelH :CGFloat = style.titleHeight
        
        for (index ,titleLabe ) in titleLabels.enumerated()
        {
            if style.isScrollEnabled {//可以滚动
                //计算文字的宽度
                
                titleLabelW = (titleLabe.text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : style.titleFont], context: nil).width
                
                titlelabelX = index == 0 ? style.titleMargin*0.5 : titleLabels[index-1].frame.maxX + style.titleMargin
                
            }
            else{
                //不可以滚动
                titlelabelX = titleLabelW * CGFloat(index)
            }
             //设置titleLabel的frame
            titleLabe.frame = CGRect(x: titlelabelX, y: titleLabelY, width: titleLabelW, height: titleLabelH)
            
        }
        
        //可以滚动的情况下设置UISCrollView的滚动区域
        if style.isScrollEnabled {
            scrollView.contentSize=CGSize(width: titleLabels.last!.frame.maxX + style.titleMargin * 0.5, height: 0)
        }
        
        
        //对第一个Title进行文字缩放效果
        if style.isNeedScale {
            
            titleLabels.first?.transform = CGAffineTransform(scaleX: style.maxScale, y: style.maxScale)
            
        }
    }
    
      // MARK : 添加bottomLine并且布局
    private func setupBottomLine()
    {
        scrollView.addSubview(bottomLine)
        
        bottomLine.frame = titleLabels.first!.frame
        bottomLine.frame.size.height=style.bottomLineHeight
        bottomLine.frame.origin.y=style.titleHeight-style.bottomLineHeight
        
    }
    
      // MARK : 添加CoverView并且布局
    private func setupCoverView()
    {
        scrollView.insertSubview(coverView, at: 0)
        
        var coverViewX = titleLabels.first!.frame.origin.x
        let coverViewY = (style.titleHeight-style.coverViewHeight)*0.5
        let coverViewH = style.coverViewHeight
        var coverViewW = titleLabels.first!.frame.size.width
        
        if style.isScrollEnabled {
            coverViewX -= style.coverViewMargin
            coverViewW += style.coverViewMargin * 2
        }
        coverView.frame = CGRect(x: coverViewX, y: coverViewY, width: coverViewW, height: coverViewH)
        
        
    }
    
}
extension ZPTitleView {
    func setCurrentIndex(_ index : Int) {
        // 1.取出targetLabel
        let targetLabel = titleLabels[index]
        
        // 2.调整Title
        addjustTitles(targetLabel)
    }
}
//MARK - 点击事件
extension ZPTitleView
{
    @objc fileprivate func titleClick(_ tapGes : UITapGestureRecognizer)
    {
        // 0.校验Label是否有值
        guard let targetLabel = tapGes.view as? UILabel else {
            return
        }
        
        // 1.判断是否是之前点击的Label
        guard targetLabel.tag != currentIndex else {
            return
        }
        
        // 2.通知代理
        // 可选链: 如果可选类型有值, 则执行代码, 没有值, 什么事情都不发生
        delegate?.titleView(self, targetIndex: targetLabel.tag)
        
        // 3.调整Label
        addjustTitles(targetLabel)
    }
    
    fileprivate func addjustTitles(_ targetLabel : UILabel) {
        // 2.让之前的Label不选中, 让新的Label可以选中
        let sourceLabel = titleLabels[currentIndex]
        sourceLabel.textColor = style.normalColor
        targetLabel.textColor = style.selecteColor
        
        // 3.让新的tag作为currentIndex
        currentIndex = targetLabel.tag
        
        // 4.调整点击的Label的位置,滚动到中间去
        
        adjustLabelPosition()
        
        // 6.调整文字缩放
        if style.isNeedScale {
            UIView.animate(withDuration: 0.25, animations: {
                sourceLabel.transform = CGAffineTransform.identity
                targetLabel.transform = CGAffineTransform(scaleX: self.style.maxScale, y: self.style.maxScale)
            })
        }
        
        // 7.调整bottomLine位置
        if style.isShowBottomLine {
            UIView.animate(withDuration: 0.25, animations: {
                self.bottomLine.frame.origin.x = targetLabel.frame.origin.x
                self.bottomLine.frame.size.width = targetLabel.frame.width
            })
        }
        
        
        // 8.调整CoverView位置
        if style.isShowCover {
            UIView.animate(withDuration: 0.25, animations: {
                self.coverView.frame.origin.x = self.style.isScrollEnabled ? (targetLabel.frame.origin.x - self.style.coverViewMargin) : targetLabel.frame.origin.x
                self.coverView.frame.size.width = self.style.isScrollEnabled ? (targetLabel.frame.width + self.style.coverViewMargin * 2) : targetLabel.frame.width
            })
        }
    }
    fileprivate func adjustLabelPosition()
    {
        guard style.isScrollEnabled else { return }
        
        //调整点击Label的位置,滚动到中间位置;
        let targetLabel = titleLabels[currentIndex]
        
        var offsetX = targetLabel.center.x - bounds.width * 0.5
        
        if offsetX < 0 {
            offsetX = 0
        }
        
        //设置最大滚动范围;
        let maxOffsetX = scrollView.contentSize.width - bounds.width;
        
        if offsetX > maxOffsetX
        {
            offsetX = maxOffsetX
        }
        
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    
}
//MARK -ZPContentViewDelegate代理方法
extension ZPTitleView: ZPContentViewDelegate
{
    func contentView(_ contentView: ZPContentView, didEndScroll targetIndex: Int) {
        
        currentIndex=targetIndex
        adjustLabelPosition()
    }
    
    func contentView(_ contentView: ZPContentView, sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        
        //1.0 根据sourceIndex和TargetIndex获取对应的Label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]

        //2.0 设置颜色渐变效果;
        sourceLabel.textColor=UIColor(red: selectedRGB.0 - deltaRGB.0 * progress, green: selectedRGB.1 - deltaRGB.1 * progress, blue: selectedRGB.2 - deltaRGB.2 * progress,alpha: 1.0)
        
        targetLabel.textColor = UIColor(red: normalRGB.0 + deltaRGB.0 * progress, green: normalRGB.1 + deltaRGB.1 * progress, blue: normalRGB.2 + deltaRGB.2 * progress, alpha: 1.0)
        
        // 设置文字缩放效果
        let deltaScale = style.maxScale - 1.0
        if style.isNeedScale {
            sourceLabel.transform = CGAffineTransform(scaleX: style.maxScale - deltaScale * progress, y: style.maxScale - deltaScale * progress)
            targetLabel.transform = CGAffineTransform(scaleX: 1.0 + deltaScale * progress, y: 1.0 + deltaScale * progress)
        }
        
        let deltaWidth = targetLabel.frame.width-sourceLabel.frame.width
        let deltaX = targetLabel.frame.origin.x-sourceLabel.frame.origin.x
        
        
        //设置bottomeLine的滚动变化
        if style.isShowBottomLine {
            bottomLine.frame.origin.x = sourceLabel.frame.origin.x+deltaX * progress
            bottomLine.frame.size.width = sourceLabel.frame.width + deltaWidth * progress
        }
        
        //设置遮盖的滚动变化
        if style.isShowCover {
            coverView.frame.origin.x = style.isScrollEnabled ? (sourceLabel.frame.origin.x+deltaX * progress - style.coverViewMargin ) : (sourceLabel.frame.origin.x+deltaX * progress)
            coverView.frame.size.width = style.isScrollEnabled ? (sourceLabel.frame.width + deltaWidth * progress + style.coverViewMargin * 2) : (sourceLabel.frame.width + deltaWidth * progress)
        }
        
        // 记录最新的index
        currentIndex = targetIndex
       
    }
}


