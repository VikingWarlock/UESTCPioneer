//
//  LearnTableViewController.h
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "superTableViewController.h"

@interface LearnTableViewController : superTableViewController

- (id)initWithRequestData:(NSDictionary *)requestData entityName:(NSString *)entityName Mapping:(NSDictionary *)mapping;

@end
