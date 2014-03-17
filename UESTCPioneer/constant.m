//
//  constant.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-9.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "constant.h"
static id centerController=nil;
@implementation constant
+(id)getCenterController{
    return centerController;
}

+(void)setCenterController:(id)con{
    centerController=con;
}
@end
