//
//  NewsEntity.h
//  UESTCPioneer
//
//  Created by Sway on 14-4-15.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewsEntity : NSManagedObject

@property (nonatomic, retain) NSString * newsBody;
@property (nonatomic, retain) NSNumber * numberOfComment;
@property (nonatomic, retain) id picUrl;
@property (nonatomic, retain) NSNumber * theId;
@property (nonatomic, retain) NSString * timeAndDate;
@property (nonatomic, retain) NSString * titleBody;

@end
