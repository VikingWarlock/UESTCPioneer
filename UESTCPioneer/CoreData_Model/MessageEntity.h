//
//  MessageEntity.h
//  UESTCPioneer
//
//  Created by viking warlock on 3/17/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MessageEntity : NSManagedObject

@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * fromID;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSNumber * in_out_type;
@property (nonatomic, retain) NSNumber * msgType;

@end
