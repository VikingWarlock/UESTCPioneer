//
//  PersonalBirthEntity.h
//  UESTCPioneer
//
//  Created by 张众 on 4/12/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PersonalBirthEntity : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * daysLeft;
@property (nonatomic, retain) NSNumber * flag;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSString * username;

@end
