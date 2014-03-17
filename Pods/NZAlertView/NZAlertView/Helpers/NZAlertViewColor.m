//
//  NZAlertViewColor.m
//  NZAlertView
//
//  Created by Bruno Tortato Furtado on 21/01/14.
//  Copyright (c) 2014 No Zebra Network. All rights reserved.
//

#import "NZAlertViewColor.h"

@implementation NZAlertViewColor

#pragma mark -
#pragma mark - Public methods

+ (UIColor *)errorColor
{
    return [UIColor colorWithRed:0.655 green:0.000 blue:0.060 alpha:1.000];
}

+ (UIColor *)infoColor
{
    return [UIColor colorWithRed:0.988 green:0.306 blue:0.180 alpha:1.000];
}

+ (UIColor *)successColor
{
    return [UIColor colorWithRed:0.078 green:0.596 blue:0.243 alpha:1.000];
}

@end