//
//  Unread.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-19.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kUnreadTotalKey @"totalUnread"//未读消息总数
#define kUnreadPioneerKey @"pioneerUnread"//成电先锋未读消息
#define kUnreadPartyNoticeKey @"UnreadPartyNotice" //党委通知未读消息
#define kUnreadPublicity @"UnreadPublicity" //公示公告未读消息
#define kUnreadPartyActivity @"UnreadPartyActivity" //组织活动未读消息
#define kUnreadMoodShare @"UnreadMoodShare" //心情分享未读消息



@interface Unread : NSObject
+(NSInteger)getUnreadNumWithKey:(NSString*)key;
+(void)setUnreadNum:(NSInteger)num ForKey:(NSString*)key;
@end
