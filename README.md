# ZPSegmentBar 该框架分为OC和Swfit两个版本:点击前往[OC版本](https://github.com/Guanzhangpeng/ZPSegmentBarOC)
[![CI Status](http://img.shields.io/travis/gzp/ZPSegmentBar.svg?style=flat)](https://travis-ci.org/gzp/ZPSegmentBar)
[![Version](https://img.shields.io/cocoapods/v/ZPSegmentBar.svg?style=flat)](http://cocoapods.org/pods/ZPSegmentBar)
[![License](https://img.shields.io/cocoapods/l/ZPSegmentBar.svg?style=flat)](http://cocoapods.org/pods/ZPSegmentBar)
[![Platform](https://img.shields.io/cocoapods/p/ZPSegmentBar.svg?style=flat)](http://cocoapods.org/pods/ZPSegmentBar)

该框架的主要功能包括两部分:

### 模仿今日头条或者是网易新闻 NavigationBar 效果,效果图如下:
 
![scroll.gif](http://upload-images.jianshu.io/upload_images/1154433-56621400635e2bf0.gif?imageMogr2/auto-orient/strip)                           
![scroll2.gif](http://upload-images.jianshu.io/upload_images/1154433-5e2d81b327126e04.gif?imageMogr2/auto-orient/strip)


 集成该框架非常的方便,我们只需要调用 
 
 ```
 let segmentView = ZPSegmentBarView(frame: frame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
 ``` 
 
 即可创建该View,然后传入相关的参数即可 
 
### 封装了一个表情键盘或者是礼物键盘,效果图如下:
 
![2.gif](http://upload-images.jianshu.io/upload_images/1154433-09d3c6d7b0a93d86.gif?imageMogr2/auto-orient/strip)

集成该框架非常的方便,我们只需要传入需要的参数即可,同时需要成为`ZPPageBarView`的数据源代理,实现相关的数据源方法即可,例如:

```
let titles = ["热门", "高级", "专属", "豪华"]
var  style  = ZPStyle()
   
style.isScrollEnabled = false
   
let layout = ZPPageBarLayout()
layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
layout.minimumLineSpacing=10
layout.minimumInteritemSpacing=10
layout.columns=8
layout.rows = 3
   
   
let frame = CGRect(x: 0, y: 100, width:view.bounds.width, height: 300)
   
let pageBarView = ZPPageBarView(frame: frame, titles: titles, style: style, layout: layout)
//设置数据源
pageBarView.dataSource=self
   
pageBarView.registerCell(UICollectionViewCell.self, reusableIdentifier: kCollectionViewCellID)
   
view.addSubview(pageBarView)

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


