# ZPSegmentBar 该框架分为OC和Swfit两个版本:点击前往[OC版本](https://github.com/Guanzhangpeng/ZPSegmentBarOC)


## 该框架的主要功能包括两部分:

### 1. 模仿今日头条或者是网易新闻 NavigationBar 效果,效果图如下:
 
![scroll.gif](http://upload-images.jianshu.io/upload_images/1154433-56621400635e2bf0.gif?imageMogr2/auto-orient/strip)                           
![scroll2.gif](http://upload-images.jianshu.io/upload_images/1154433-5e2d81b327126e04.gif?imageMogr2/auto-orient/strip)


#### 集成该框架的主要步骤:

##### 1. 导入头文件 `import ZPSegmentBar`
##### 2. 实例化`ZPStyle`,并且传入我们需要的样式,例如:
```
var style = ZPStyle()
style.isScrollEnabled=true; //标题是否可以滚动,默认为true;
style.isShowCover = true    //标题是否显示遮盖,默认为true;
style.isShowBottomLine=true //标题下方是否显示BottomLine,默认为true;
style.isNeedScale=true      //标题文字是否缩放,默认为true;
.
.
.
```
##### 3. 实例化 `ZPSegmentBarView`,并且传入所需要的参数
```
let segmentView = ZPSegmentBarView(frame: frame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
```
##### 4. 将创建好的 `ZPSegmentBarView` 添加到当前View中即可
```
view.addSubview(segmentView)
```

 
### 2. 封装了一个表情键盘或者是礼物键盘,效果图如下:
 
![2.gif](http://upload-images.jianshu.io/upload_images/1154433-09d3c6d7b0a93d86.gif?imageMogr2/auto-orient/strip)

#### 集成该功能的主要步骤:
##### 1. 和上面的步骤一样,导入头文件 `import ZPSegmentBar`
##### 2. 和上面的步骤一样,实例化`ZPStyle`,并且传入我们需要的样式,例如:
```
var style = ZPStyle()
style.isScrollEnabled=false; //标题是否可以滚动,默认为true;
style.isShowCover = false    //标题是否显示遮盖,默认为true;
style.isShowBottomLine=true //标题下方是否显示BottomLine,默认为true;
style.isNeedScale=true      //标题文字是否缩放,默认为true;
.
.
.
```
##### 3. 实例化`ZPPageBarLayout`布局,并且传入我们需要的样式,例如:
```
let layout = ZPPageBarLayout()
layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
layout.minimumLineSpacing=10         //行距
layout.minimumInteritemSpacing=10    //item之间的间距
layout.columns=8                     //列数
layout.rows = 3                      //行数
```
##### 4. 实例化`ZPPageBarView`,并且传入我们需要的参数,设置数据源代理,注册cell
```
let pageBarView = ZPPageBarView(frame: frame, titles: titles, style: style, layout: layout)

pageBarView.dataSource=self     //设置数据源代理,并且实现数据源方法

pageBarView.registerCell(UICollectionViewCell.self, reusableIdentifier: kCollectionViewCellID)
view.addSubview(pageBarView)

```
##### 5.实现数据源方法

```
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
```


## 注意
如果是导航控制器,我们需要在集成的View中 设置 ` automaticallyAdjustsScrollViewInsets=false`

## Installation

ZPSegmentBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZPSegmentBar', '~> 0.1.5'
```

## Author
[简书连接](http://www.jianshu.com/u/68bedf0c5c86)

gzp, zswangzp@163.com

## License

ZPSegmentBar is available under the MIT license. See the LICENSE file for more info.


