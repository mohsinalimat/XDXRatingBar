# XDXRatingBar

![logo](https://raw.githubusercontent.com/6xieapplexia6/XDXResources/master/XDXRatingBar_intro.png)
<br/><br/>
![Platform](https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=plastic)
![Languages](https://img.shields.io/badge/language-swift%20|%20objc-FF69B4.svg?style=plastic)
![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=plastic)

## Table of contents - 目录
* [Introduction](#introduction)
* [简介](#introductionCHS)
* [Installation](#installation)
* [安装说明](#installationCHS)
* [Tips](#tips)
* [使用技巧](#tipsCHS)
* [Support XDXRatingBar](#support)
* [Contact](#contact)
* [License](#license)

### <a id="introduction"></a>Introduction

The GitHub repo [XDXRatingBar](https://github.com/6xieapplexia6/XDXRatingBar) was originally inspired by [iOS-RatingBar](https://github.com/saiwu-bigkoo/iOS-RatingBar) written by GitHub user [saiwu-bigkoo](https://github.com/saiwu-bigkoo) with the enhancements of: 

1. @IBDesignable and @IBInspectable for the class, so developers can set the attributes and preview the UI behaviors in Xcode storyboard or xib files;
2. The singleton class XDXRatingBarManager can help developers to configure all XDXRatingBar instances globally;
3. More little enhanced features will be introduced below.

### <a id="introductionCHS"></a>简介

该 GitHub 仓库是基于 [saiwu-bigkoo](https://github.com/saiwu-bigkoo) 的仓库 [iOS-RatingBar](https://github.com/saiwu-bigkoo/iOS-RatingBar) 改编并强化之作，相比 iOS-RatingBar 而言，XDXRatingBar 强化了：

1. @IBDesignable 和 @IBInspectable 可以让开发者设置 XDXRatingBar 的属性并预览 UI 效果；
2. 为开发者设置全局属性提供了了含单例 shared 的类 XDXRatingBarManager；
3. 将在使用技巧中介绍更多的加强。

### <a id="installation"></a>Installation
The easiest way to install this API on an iOS project is to copy the file XDXRatingBar.swift into the Xcode project folder.
Cocoapods installation will be available in the future.

### <a id="installationCHS"></a>安装说明
把 XDXRatingBar 安装到 iOS 项目的最简单的方式可以是直接把 XDXRatingBar.swift 复制到 iOS 项目的 Xcode 项目文件夹中。
在不久的未来，将支持使用 Cocoapods 安装。

### <a id="tips"></a>Tips

#### XDXRatingBar - Variables

1. The variable "maxRating" should be the multiple of the variable "numberOfStars". In most cases, I'll recommend to set them as the same of each other.

2. The variable "animated" indicates whether XDXRatingBar instance should perform animation when the rating is changed. The value of the variable "animationTimeInterval" will be useless if "animated" is set to false.

3. The variable "isDecimalRating" indicates whether the rating of XDXRatingBar instance is a decimal or an integer.

4. The variable "isIndicator" determines whether users can change rating by tapping XDXRatingBar. However, the rating can still be changed programmatically even if it's true.

5. The variable "starWidthInsetRatio" sets the gap between star images. The value should be set to 0 ~ 0.5.

6. The variable "isDisplayingUnselectedStars" indicates whether unselected star images should display or not. If it's set to false, the value of "imageForUnselectedStars" will be useless (suggesting to set image to nil).

#### XDXRatingBarManager

XDXRatingBarManager is a class containing a singleton instance for configuring all XDXRatingBar instances in the project. Let's have an example:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool 
{
    configXDXRatingBarGlobally()
    return true
}

func configXDXRatingBarGlobally()
{
    XDXRatingBarManager.shared.minRating = 1
    XDXRatingBarManager.shared.maxRating = 5
    XDXRatingBarManager.shared.numberOfStars = 5
    XDXRatingBarManager.shared.animated = true
    XDXRatingBarManager.shared.animationTimeInterval = 0.2
    XDXRatingBarManager.shared.isDecimalRating = false
    XDXRatingBarManager.shared.isIndicator = false
    XDXRatingBarManager.shared.starWidthInsetRatio = 0.05
}
```

Simply copy this piece of code and do a little modification based on what you need in the project's AppDelegate file. So you don't have to override either in coding files or in xib / storyboard files everytime when XDXRatingBar is created. All variables in XDXRatingBarManager are optional, so you are not required to do this in AppDelegate.

#### XDXRatingBarDelegate

If you need to do something when the rating of XDXRatingBar is changed. You can simply confirm the protocol in view-controller or view-cell classes like:

```swift
class ViewController: UIViewController, XDXRatingBarDelegate
```

You can either set delegate programmatically or drag in xib / storyboard files.

First way: 
```swift
@IBOutlet weak var ratingBar: XDXRatingBar! {
    didSet { ratingBar.delegate = self }
}
```

Second way:
```swift
override func viewDidLoad()
{
    super.viewDidLoad()
        
    ratingBar.delegate = self
}
```

Then do what you want to do in the method "ratingWillChange" or "ratingDidChange". You are not required to implement this method (since the method in protocol is optional) even when you confirm protocol in the classes.

```swift
func ratingWillChange(_ ratingBar: XDXRatingBar, oldRating: CGFloat, newRating: CGFloat)
{
    print("ratingWillChange oldRating: \(oldRating)")
}

func ratingDidChange(_ ratingBar: XDXRatingBar, oldRating: CGFloat, newRating: CGFloat)
{
    print("ratingDidChange newRating: \(newRating)")
}
```

### <a id="tipsCHS"></a>使用技巧

#### XDXRatingBar - 变量

1. 变量 maxRating (最高评分) 必须是变量 numberOfStars(星星数量) 的倍数。建议设置为相等的值。

2. 变量 animated (显示动画) 声明 XDXRatingBar 实例是否需要在评分变化的时候显示动画。

3. 变量 isDecimalRating (小数型评分) 声明 XDXRatingBar 评分是小数还是整数。

4. 变量 isIndicator (指示器) 意思为 iOS 用户是否不可以通过点击 XDXRatingBar 来修改评分。即使该变量值为 true，评分仍可通过代码实现来修改。

5. 变量 starWidthInsetRatio (星星之间宽空隙指数) 可用来设置星星图片间距。变量的值需在 0 ~ 0.5 之间。

6. 变量 isDisplayingUnselectedStars (显示未选中星星) 声明未选中的星星是否需要显示。如果值为 false 的话，那么 imageForUnselectedStars (未选中星星的图片) 就不会起作用 (建议在此将其设置为 nil)。

#### XDXRatingBarManager

类 XDXRatingBarManager 包含了一个单例来配置所有在项目中的 XDXRatingBar 实例。示例如下：

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool 
{
    configXDXRatingBarGlobally()
    return true
}

func configXDXRatingBarGlobally()
{
    XDXRatingBarManager.shared.minRating = 1
    XDXRatingBarManager.shared.maxRating = 5
    XDXRatingBarManager.shared.numberOfStars = 5
    XDXRatingBarManager.shared.animated = true
    XDXRatingBarManager.shared.animationTimeInterval = 0.2
    XDXRatingBarManager.shared.isDecimalRating = false
    XDXRatingBarManager.shared.isIndicator = false
    XDXRatingBarManager.shared.starWidthInsetRatio = 0.05
}
```

复制以上代码到 iOS 项目的 AppDelegate 文件中，并根据需要作出修改。就不需要每次都在代码、xib 或 storyboard 文件重新配置 XDXRatingBar 了。该类内都是 optional 变量，所以以上代码并不需要出现在 iOS 项目中。

#### XDXRatingBarDelegate

如果需要在评分有变化的时候运行一些代码，可以在 view-controller 或 view-cell 的类中确定 protocol：

```swift
class ViewController: UIViewController, XDXRatingBarDelegate
```

delegate 可以像如下代码实现，也可以在 xib / storyboard 文件中配置。

第一种方式: 
```swift
@IBOutlet weak var ratingBar: XDXRatingBar! {
    didSet { ratingBar.delegate = self }
}
```

第二种方式:
```swift
override func viewDidLoad()
{
    super.viewDidLoad()
        
    ratingBar.delegate = self
}
```

最后添加代码在 ratingWillChange 或 ratingDidChange 方法中。这两个方法不是必需的，即使 protocol 被类确认。

```swift
func ratingWillChange(_ ratingBar: XDXRatingBar, oldRating: CGFloat, newRating: CGFloat)
{
    print("ratingWillChange oldRating: \(oldRating)")
}

func ratingDidChange(_ ratingBar: XDXRatingBar, oldRating: CGFloat, newRating: CGFloat)
{
    print("ratingDidChange newRating: \(newRating)")
}
```

### <a id="support"></a>Support XDXRatingBar
* [**★Star**](#) this repo 

### <a id="contact"></a>Contact
* LinkedIn： [**@Chong Xie**](https://www.linkedin.com/in/chongx)

### License
XDXRatingBar is available under the MIT license. Please see the LICENSE file for more info.