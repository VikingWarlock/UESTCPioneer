//
//  Unread.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-19.
//  Copyright (c) 2014年 Sway. All rights reserved.
//
//
//
//  本类用于设置未读消息条目，未读消息通过key值来设置，设置的值可以自动保存到沙盒里
//

#import "Unread.h"

@implementation Unread


///通过key来设置未读值，若清零请把响应值设为0，不要操作总值
+(void)setUnreadNum:(NSInteger)num ForKey:(NSString*)key{
    if ([key isEqualToString:kUnreadTotalKey]){
      NSLog(@"请勿操作总值");
        return;
    }

    NSUserDefaults *defaultData= [NSUserDefaults standardUserDefaults];
    
    NSInteger totalUnread = [defaultData integerForKey:kUnreadTotalKey];
    //先删除原来存在total里的数据再添加新的
    totalUnread-=[defaultData integerForKey:key];
    totalUnread+=num;
    
    [defaultData setInteger:totalUnread forKey:kUnreadTotalKey];
    [defaultData setInteger:num forKey:key];
    //保存数据
    BOOL success=[defaultData synchronize];
    

    
    
    //发个通知消息
    if (success)[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUnreadTotalRefreshed object:@(totalUnread)];
    
}


///通过key获取未读消息数
+(NSInteger)getUnreadNumWithKey:(NSString*)key{
    NSUserDefaults *defaultData= [NSUserDefaults standardUserDefaults];
    return [defaultData integerForKey:key];
}



@end
