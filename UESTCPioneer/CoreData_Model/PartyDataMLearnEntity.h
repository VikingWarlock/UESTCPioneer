//
//  PartyDataMLearnEntity.h
//  UESTCPioneer
//
//  Created by 马君 on 14-4-16.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PartyDataMLearnEntity : NSManagedObject

@property (nonatomic, retain) NSString * comeCode;
@property (nonatomic, retain) NSString * comeFrom;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) NSString * fileType;
@property (nonatomic, retain) NSNumber * theId;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * typeText;

@end
