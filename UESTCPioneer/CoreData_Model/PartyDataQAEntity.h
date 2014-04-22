//
//  PartyDataQAEntity.h
//  UESTCPioneer
//
//  Created by 马君 on 14-4-18.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PartyDataQAEntity : NSManagedObject

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSString * answerName;
@property (nonatomic, retain) NSNumber * theId;
@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSString * time_ans;
@property (nonatomic, retain) NSString * time_que;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSString * userName;

@end
