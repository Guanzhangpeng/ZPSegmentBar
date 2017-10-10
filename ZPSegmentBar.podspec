#
# Be sure to run `pod lib lint ZPSegmentBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZPSegmentBar'
  s.version          = '0.1.5'
  s.summary          = '今日头条-网易新闻-导航栏效果 表情键盘'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 模仿今日头条 网易新闻等的NavigationBar效果;表情键盘集成
                       DESC

  s.homepage         = 'https://github.com/Guanzhangpeng/ZPSegmentBar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gzp' => 'zswangzp@163.com' }
  s.source           = { :git => 'https://github.com/Guanzhangpeng/ZPSegmentBar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZPSegmentBar/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZPSegmentBar' => ['ZPSegmentBar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
