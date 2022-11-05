# PitTabbarController

[![CI Status](https://img.shields.io/travis/imwalsh/PitTabbarController.svg?style=flat)](https://travis-ci.org/imwalsh/PitTabbarController)

## Example

![PitTabbarController]([https://github.com/imWalsh/PitTabbarController/blob/main/Resources/screenshot.png]#pic_center)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<img src="https://github.com/imWalsh/PitTabbarController/blob/main/Resources/Screen%20Recording.gif" height="500"/>

## Requirements
* Xcode 11+
* iOS 13.0+
* Swift 5.0

## Installation

PitTabbarController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PitTabbarController'
```

## Basic usage

1. Add `pod 'PitTabbarController'` to your Podfile.
2. AppDelegate

```swift
	let tabBarController = PitTabbarController()
        
	tabBarController.viewControllers = [v1, v2, v3, v4]
        
	window?.rootViewController = tabBarController
```

## Author

imWalsh, wshjay@live.cn

## License

PitTabbarController is available under the MIT license. See the LICENSE file for more info.
