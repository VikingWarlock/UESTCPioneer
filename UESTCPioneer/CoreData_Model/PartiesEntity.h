//
//  PartiesEntity.h
//  UESTCPioneer
//
//  Created by Sway on 14-4-3.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PartiesEntity : NSManagedObject

@property (nonatomic, retain) NSString * partyName;
@property (nonatomic, retain) NSString * partyNo;

@end
