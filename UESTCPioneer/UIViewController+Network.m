//
//  UIViewController+Network.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-22.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "UIViewController+Network.h"
#import <objc/runtime.h>

static NSString *theIdKey=@"theId";

@implementation UIViewController (Network)
-(void)setTheId:(NSInteger)theId
{
    objc_setAssociatedObject(self, &theIdKey, @(theId), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)theId
{
     NSNumber *num= objc_getAssociatedObject(self, &theIdKey);
    return [num integerValue];
}

@end


