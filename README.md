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

## Example
![scroll.gif](http://upload-images.jianshu.io/upload_images/1154433-56621400635e2bf0.gif?imageMogr2/auto-orient/strip)                           ![scroll2.gif](http://upload-images.jianshu.io/upload_images/1154433-5e2d81b327126e04.gif?imageMogr2/auto-orient/strip)

 `ZPStyle`这个结构体是用来封装该框架的一些样式,我们可以通过简单的配置来达到我们想要的效果,例如:
```
var style = ZPStyle()
style.isShowCover = true    //显示遮盖
style.isShowBottomLine=true //显示BottomLine
style.isNeedScale=true      //文字缩放
```
具体的一些属性设置,可以查看 该结构体内部;


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


