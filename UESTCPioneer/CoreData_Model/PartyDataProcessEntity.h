//
//  PartyDataProcessEntity.h
//  UESTCPioneer
//
//  Created by 马君 on 14-4-13.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PartyDataProcessEntity : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * dangType;
@property (nonatomic, retain) NSNumber * theId;
@property (nonatomic, retain) NSNumber * picPath;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * title;

@end
