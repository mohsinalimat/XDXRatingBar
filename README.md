# XDXRatingBar

![Languages](https://img.shields.io/badge/language-swift%20|%20objc-FF69B4.svg?style=plastic)

## Table of contents
* [Introduction](#introduction)
* [Screenshots](#screenshots)
* [Installation](#installation)
* [Tips](#tips)
* [Support](#support)
* [Contact](#contact)
* [License](#license)

### <a id="introduction"></a>Introduction

The GitHub project [XDXRatingBar](https://github.com/6xieapplexia6/XDXRatingBar) was originally inspired by [iOS-RatingBar](https://github.com/saiwu-bigkoo/iOS-RatingBar) written by GitHub user [saiwu-bigkoo](https://github.com/saiwu-bigkoo) with the enhancements of: 

1. @IBDesignable and @IBInspectable for the class, so developers can set the attributes and preview the UI behaviors in Xcode storyboard or xib files;
2. The singleton class XDXRatingBarManager can help developers to configure all XDXRatingBar instances globally;
3. More little enhanced features will be introduced below.

<br/>

### <a id="screenshots"></a>Screenshots
![XDXRatingBar](https://github.com/6xieapplexia6/XDXRatingBar/one_star.png)
![XDXRatingBar](https://github.com/6xieapplexia6/XDXRatingBar/three_stars.png)
<br/>

### <a id="installation"></a>Installation
In progress...
<br/>

### <a id="tips"></a>Tips

1. The variable "maxRating" should be the multiple of the variable "numberOfStars". In most cases, I'll recommend to set them as the same of each other.

2. The variable "animated" indicates whether XDXRatingBar instance should perform animation when the rating is changed. The value of the variable "animationTimeInterval" will be useless if "animated" is set to false.

3. The variable "isDecimalRating" indicates whether the rating of XDXRatingBar instance is a decimal or an integer.

4. The variable "isIndicator" determines whether users can change rating by tapping XDXRatingBar. However, the rating can still be changed programmatically.

5. The variable "starWidthInsetRatio" sets the gap between star images. The value should be set between 0 ~ 0.5.

6. The variable "isDisplayingUnselectedStars" indicates whether unselected star images should display or not. If it's set to false, the value of "imageForUnselectedStars" will be useless (suggesting to set image to nil).

<br/>

### <a id="support"></a>Support this repo
* [**★Star**](#) this repo 
<br/>

### <a id="contact"></a>Contact
* LinkedIn： [**@Chong Xie**](https://www.linkedin.com/in/chongx)
<br/>

### License
XDXRatingBar is available under the MIT license. Please see the LICENSE file for more info.