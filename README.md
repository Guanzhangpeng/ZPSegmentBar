# ZPSegmentBar

[![CI Status](http://img.shields.io/travis/gzp/ZPSegmentBar.svg?style=flat)](https://travis-ci.org/gzp/ZPSegmentBar)
[![Version](https://img.shields.io/cocoapods/v/ZPSegmentBar.svg?style=flat)](http://cocoapods.org/pods/ZPSegmentBar)
[![License](https://img.shields.io/cocoapods/l/ZPSegmentBar.svg?style=flat)](http://cocoapods.org/pods/ZPSegmentBar)
[![Platform](https://img.shields.io/cocoapods/p/ZPSegmentBar.svg?style=flat)](http://cocoapods.org/pods/ZPSegmentBar)

一款模仿今日头条或者是网易新闻 NavigationBar 的框架,使用起来非常简单,只需要一句代码就可以集成该框架

```
//创建ZPSegmentBarView
let segmentView = ZPSegmentBarView(frame: frame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
   
view.addSubview(segmentView)
```

## HOW TO USE
![scroll.gif](http://upload-images.jianshu.io/upload_images/1154433-56621400635e2bf0.gif?imageMogr2/auto-orient/strip)                           
![scroll2.gif](http://upload-images.jianshu.io/upload_images/1154433-5e2d81b327126e04.gif?imageMogr2/auto-orient/strip)

 `ZPStyle`这个结构体是用来封装该框架的一些样式,我们可以通过简单的配置来达到我们想要的效果,例如:
 
```
import UIKit
import ZPSegmentBar  //导入框架名称
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets=false
        
        let frame=CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        //1.0 设置显示的title
        let titles = ["推荐321","热点3","直播6666","视频","阳光视频","社会热点","娱乐","科技","汽车"]
        
        
        //2.0 设置自己喜欢的样式,该结构体提供了多种样式供使用
        var style = ZPStyle()
        style.isShowCover = true    //显示遮盖
        style.isShowBottomLine=true //显示BottomLine
        style.isNeedScale=true      //文字缩放
        
        //3.0 设置控制器
        var childVcs = [UIViewController]()
        for _ in titles {
            let vc = UIViewController()
            vc.view.backgroundColor=UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
            childVcs.append(vc)
        }
        
        //4.0 创建ZPSegmentBarView
        let segmentView = ZPSegmentBarView(frame: frame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        
        view.addSubview(segmentView)
    }

```



## Installation

ZPSegmentBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZPSegmentBar"
```

## Author
[简书连接](http://www.jianshu.com/u/68bedf0c5c86)

gzp, zswangzp@163.com

## License

ZPSegmentBar is available under the MIT license. See the LICENSE file for more info.


