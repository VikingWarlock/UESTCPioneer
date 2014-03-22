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


///制作navigationbar上的按钮
+(UIBarButtonItem*)BarButtonItemWithUIButton:(UIButton*)button{
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:customView.bounds];
    [customView addSubview:button];
//    [button setImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
//    [button setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
//    [button addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:customView];
    return right;
}

+(UIBarButtonItem*)BarButtonItemWithUIButton:(UIButton*)button ButtonOrigin:(CGPoint)point{
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect bo=customView.bounds;
    bo.origin=point;
    [button setFrame:bo];
    [customView addSubview:button];
    //    [button setImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    //    [button setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    //    [button addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:customView];
    return right;
}

+(UIBarButtonItem*)BarButtonItemWithUIButton:(UIButton*)button ButtonOrigin:(CGPoint)point CustomViewSize:(CGSize)size{
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,size.width,size.height)];
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect bo=customView.bounds;
    bo.origin=point;
    [button setFrame:bo];
    [customView addSubview:button];
    //    [button setImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    //    [button setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    //    [button addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:customView];
    return right;

}

@end
