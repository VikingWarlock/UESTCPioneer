//
//  AppDelegate.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-5.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"

@class LeveyTabBarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;
//@property(strong,nonatomic)    UINavigationController *centerViewController;
@end
