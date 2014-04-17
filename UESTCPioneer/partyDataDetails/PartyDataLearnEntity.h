//
//  PartyDataLearnEntity.h
//  UESTCPioneer
//
//  Created by 马君 on 14-4-13.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PartyDataLearnEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * theId;
@property (nonatomic, retain) NSString * filename;

@end
