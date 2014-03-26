//
//  MoodShareNewsEntity.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-22.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NewsEntity.h"


@interface MoodShareNewsEntity : NewsEntity

@property (nonatomic, retain) NSString * picUrl;
@property (nonatomic, retain) NSString * userId;

@end
