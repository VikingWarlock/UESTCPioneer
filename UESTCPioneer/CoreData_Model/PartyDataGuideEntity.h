//
//  PartyDataGuideEntity.h
//  UESTCPioneer
//
//  Created by 马君 on 14-4-15.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PartyDataGuideEntity : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * picName;
@property (nonatomic, retain) NSString * picUrl;
@property (nonatomic, retain) NSNumber * theId;
@property (nonatomic, retain) NSString * time;

@end
