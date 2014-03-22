//
//  PioneerNewsEntity.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-22.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NewsEntity.h"


@interface PioneerNewsEntity : NewsEntity

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * count;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString* picName;
@property (nonatomic, retain) NSString* picUrl;
@property (nonatomic, retain) NSString* type;

@end
