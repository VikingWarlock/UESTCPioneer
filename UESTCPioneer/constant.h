//
//  constant.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-9.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNavigationBarColor [UIColor colorWithRed:192.0/255.0 green:57.0/255.0 blue:43.0/255.0 alpha:1]
#define IS_IOS7 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)

#define IS_4INCH (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568)<DBL_EPSILON)

#define kNotificationUnreadTotalRefreshed @"NotificationUnreadTotalRefreshed"


@interface constant : NSObject
+(id)getCenterController;
+(void)setCenterController:(id)con;
@end
