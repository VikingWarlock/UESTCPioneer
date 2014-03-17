#NZAlertView ![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)

Simple and intuitive alert view. Similar to push notification effect.
This class uses UIAlertView default methods and protocols.

<p align="center">
  <img src="http://s14.postimg.org/rfqbn70qp/NZAlert_View.png" alt="NZAlertView" title="NZAlertView" width="500" height="250">
</p>
<br/>
<p align="center">
  <a href="http://youtu.be/FCZKKN5W9Cc"><img src="http://s10.postimg.org/9n918glqh/NZAlert_View.png" alt="NZAlertView" title="NZAlertView" width="500" height="300"></a>
</p>
<br/>
[![Build Status](https://api.travis-ci.org/NZN/NZAlertView.png)](https://api.travis-ci.org/NZN/NZAlertView.png)
[![Cocoapods](https://cocoapod-badges.herokuapp.com/v/NZAlertView/badge.png)](http://beta.cocoapods.org/?q=NZAlertView)
[![Cocoapods](https://cocoapod-badges.herokuapp.com/p/NZAlertView/badge.png)](http://beta.cocoapods.org/?q=NZAlertView)

## Requirements

NZAlertView works on iOS 5.0+ version and is compatible with ARC projects. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

* Foundation.framework

You will need LLVM 3.0 or later in order to build NZAlertView.

NZAlertView use [UIImage-Helpers](https://github.com/NZN/UIImage-Helpers) project for manipulating images.

## Adding NZAlertView to your project

### Cocoapods

[CocoaPods](http://cocoapods.org) is the recommended way to add NZAlertView to your project.

* Add a pod entry for NZAlertView to your Podfile:

```
pod 'NZAlertView'
```

* Install the pod(s) by running:

```
pod install
```

### Source files

Alternatively you can directly add source files to your project.

1. Download the [latest code version](https://github.com/NZN/NZAlertView/archive/master.zip) or add the repository as a git submodule to your git-tracked project.
2. Open your project in Xcode, then drag and drop all files at `NZAlertView` folder onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project.

## Usage

###Info

* Works at __iPad__ and __iPhone__
* Works with or without status bar 
* Only works at __portrait mode__
* The alert duration time can be modified (default: __5 seconds__)
* The animation duration time can be modified (default: __0.6 seconds__)
* The text alignment can be changed (default: __left alignment__)
* Only 1 alert is displayed at a time
* Delegates are similar to `UIAlertView`


###Styles

* NZAlertStyleError
* NZAlertStyleSuccess
* NZAlertStyleInfo

###Show

```objetive-c
#import "NZAlertView.h"
...
{
    // There are several ways to init, just look at the class header
    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleSuccess
                                                      title:@"Alert View"
                                                    message:@"This is an alert example."
                                                   delegate:nil];
                                                   
    [alert setTextAlignment:NSTextAlignmentCenter];

	[alert show];      
	
	// or
	
	[alert showWithCompletion:^{
    NSLog(@"Alert with completion handler");
	}];                                            
}

```

###Delegate

* All delegates are optional

```objetive-c
#import "NZAlertViewDelegate.h"
...

- (void)willPresentNZAlertView:(NZAlertView *)alertView;
- (void)didPresentNZAlertView:(NZAlertView *)alertView;

- (void)NZAlertViewWillDismiss:(NZAlertView *)alertView;
- (void)NZAlertViewDidDismiss:(NZAlertView *)alertView;

```

###Setters and getters

```objetive-c
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) NZAlertStyle alertViewStyle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, readonly, getter = isVisible) BOOL visible;
@property (nonatomic) NSTextAlignment textAlignment;
```

###Images and colors

* If you want to change, the images are in the bundle: `NZAlertView-Icons.budle`
* To customize the colors, extend the `NZAlertViewColor` class and override the methods: `errorColor`, `infoColor` and `successColor`.

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each NZAlertView release can be found on the [wiki](https://github.com/NZN/NZAlertView/wiki/Change-log).


##To-do Items

###Orientation

- Support for landscape mode
