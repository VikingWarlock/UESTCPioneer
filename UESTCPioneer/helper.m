//
//  helper.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-9.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "helper.h"

@implementation helper
+(void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

+(UIImage*)getCustomImage:(UIImage*)image insets:(UIEdgeInsets)insets{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    CGRect targetRect=CGRectMake(insets.left, insets.top, image.size.width-insets.right, image.size.height-insets.bottom);
    [image drawInRect:targetRect];
    UIImage *targetImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}
@end
