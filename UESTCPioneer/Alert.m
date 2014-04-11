//
//  Alert.m
//  Test
//
//  Created by Sway on 13-9-11.
//  Copyright (c) 2013年 Sway. All rights reserved.
//

#import "Alert.h"
#import <QuartzCore/QuartzCore.h>
@implementation Alert
+(void)showAlert:(NSString*)message{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(93, 160, 134, 104)];
    [view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [view.layer setCornerRadius:20];
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 93, 33)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:label];
    label.text=message;
    
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2];
    
    view.alpha=0;
    
    [UIView commitAnimations];
    [view performSelector:@selector(removeFromSuperview) withObject:self afterDelay:1.5];
}
@end
