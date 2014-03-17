//
//  UserEntity.h
//  UESTCPioneer
//
//  Created by viking warlock on 3/12/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserEntity : NSManagedObject

@property (nonatomic, retain) NSString * avatarID;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * userName;

@end
