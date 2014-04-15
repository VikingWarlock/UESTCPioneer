//
//  constant.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-9.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>



#pragma mark - 颜色
#define kNavigationBarColor [UIColor colorWithRed:192.0/255.0 green:57.0/255.0 blue:43.0/255.0 alpha:1]
#define ViewControllerBackgroundColor [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1]
#define kBorderColor [UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:0.8]


#define IS_IOS7 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)

#define IS_4INCH (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568)<DBL_EPSILON)

#define kNotificationUnreadTotalRefreshed @"NotificationUnreadTotalRefreshed"


#define kNewsEntityName @"NewsEntity"
#define kPioneerEntityName @"PioneerNewsEntity"
#define kPartyNoticeNewsEntityName @"PartyNoticeNewsEntity"
#define kPublicityNewsEntityName @"PublicityNewsEntity"
#define kPartyActivityNewsEntityName @"PartyActivityNewsEntity"
#define kMoodShareNewsEntityName @"MoodShareNewsEntity"
#define kPartiesEntityName @"PartiesEntity"




#define debugMode 0

@interface constant : NSObject
+(id)getCenterController;
+(void)setCenterController:(id)con;
+(NSString*)getUserId;
+(void)setUserId:(NSString*)user;
+(NSString*)getUserName;
+(void)setUserName:(NSString*)name;


+(NSDictionary*)getPersonalInfo;
+(void)setPersonalInfo:(NSDictionary*)info;

+(NSString*)getName;

+(void)setName:(NSString*)name;

@end
