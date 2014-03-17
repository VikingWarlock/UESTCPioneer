//
//  NewsEntity.h
//  UESTCPioneer
//
//  Created by viking warlock on 3/13/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewsEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * authorID;
@property (nonatomic, retain) NSString * authorName;
@property (nonatomic, retain) NSNumber * canJoin;
@property (nonatomic, retain) NSNumber * isMarked;
@property (nonatomic, retain) NSNumber * isShared;
@property (nonatomic, retain) NSString * newsBody;
@property (nonatomic, retain) NSNumber * numberOfComment;
@property (nonatomic, retain) NSNumber * numberOfShare;
@property (nonatomic, retain) NSDate * timeAndDate;
@property (nonatomic, retain) NSString * titleBody;
@property (nonatomic, retain) NSString * catagory;

@end
