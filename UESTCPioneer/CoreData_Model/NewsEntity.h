//
//  NewsEntity.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-22.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewsEntity : NSManagedObject

@property (nonatomic, retain) NSString * newsBody;
@property (nonatomic, retain) NSNumber * numberOfComment;
@property (nonatomic, retain) NSDate * timeAndDate;
@property (nonatomic, retain) NSString * titleBody;
@property (nonatomic, retain) NSNumber * theId;

@end
