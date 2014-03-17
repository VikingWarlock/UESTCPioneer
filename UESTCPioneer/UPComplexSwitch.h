//
//  UPComplexSwitch.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-6.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPSwitch.h"

@interface UPComplexSwitch :UPSwitch
-(void)setOnFrontImage:(UIImage*)image;
-(void)setOffFrontImage:(UIImage*)image;
-(void)setFrontImageInsets:(UIEdgeInsets)insets;
@end
