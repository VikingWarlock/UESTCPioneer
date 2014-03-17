//
//  helper.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-9.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface helper : NSObject
+(void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay;
+(UIImage*)getCustomImage:(UIImage*)image insets:(UIEdgeInsets)insets;
@end
