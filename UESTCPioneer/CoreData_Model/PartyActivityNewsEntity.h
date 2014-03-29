//
//  PartyActivityNewsEntity.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-28.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NewsEntity.h"


@interface PartyActivityNewsEntity : NewsEntity

@property (nonatomic, retain) NSString * branch;
@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSString * institute;
@property (nonatomic, retain) NSNumber * love;
@property (nonatomic, retain) NSNumber * signUp;
@property (nonatomic, retain) NSNumber * top;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * zipPicUrl;

@end
