//
//  PioneerNewsEntity.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-28.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NewsEntity.h"


@interface PioneerNewsEntity : NewsEntity

@property (nonatomic, retain) NSString * comeCode;
@property (nonatomic, retain) NSString * comeFrom;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * picName;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * zipPicUrl;

@end
