//
//  PartyDataGuideDetailEntity.h
//  UESTCPioneer
//
//  Created by 马君 on 14-4-16.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PartyDataGuideDetailEntity : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * picName;
@property (nonatomic, retain) NSString * picUrl;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSNumber * frontId;
@property (nonatomic, retain) NSString * frontTitle;
@property (nonatomic, retain) NSNumber * theId;
@property (nonatomic, retain) NSNumber * nextId;
@property (nonatomic, retain) NSString * nextTitle;

@end
