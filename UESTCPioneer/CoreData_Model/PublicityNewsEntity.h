//
//  PublicityNewsEntity.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-28.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NewsEntity.h"


@interface PublicityNewsEntity : NewsEntity

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSNumber * chakan;
@property (nonatomic, retain) NSString * comform;
@property (nonatomic, retain) NSNumber * shoucang;
@property (nonatomic, retain) NSNumber * transnum;
@property (nonatomic, retain) NSString * userId;

@end
