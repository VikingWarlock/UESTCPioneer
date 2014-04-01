//
//  constant.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-9.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "constant.h"
static id centerController=nil;


static NSString *userId =@"";
static NSString *userName=@"";
static NSString *Name=@"";
@implementation constant
+(id)getCenterController{
    return centerController;
}

+(void)setCenterController:(id)con{
    centerController=con;
    }

+(NSString*)getUserId{
    return userId;
}

+(void)setUserId:(NSString*)user{
    userId=user;
}

+(NSString*)getUserName{
    return userName;
}

+(void)setUserName:(NSString*)name{
    userName=name;
}


+(NSString*)getName{
    return Name;
}

+(void)setName:(NSString*)name{
    Name=name;
}

@end
