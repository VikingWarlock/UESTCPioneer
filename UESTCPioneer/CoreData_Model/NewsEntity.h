//
//  NewsEntity.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-28.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewsEntity : NSManagedObject

@property (nonatomic, retain) NSString * newsBody;
@property (nonatomic, retain) NSNumber * numberOfComment;
@property (nonatomic, retain) NSString * picUrl;
@property (nonatomic, retain) NSNumber * theId;
@property (nonatomic, retain) NSString * timeAndDate;
@property (nonatomic, retain) NSString * titleBody;

@end
