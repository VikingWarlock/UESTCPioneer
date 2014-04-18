//
//  LearnTableViewController.h
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "superTableViewController.h"
#import "DataRefreshTableViewController.h"

@interface LearnTableViewController : DataRefreshTableViewController<UITableViewDelegate,UITableViewDataSource>

- (id)initWithRequestData:(NSDictionary *)RequestData entityName:(NSString *)EntityName Mapping:(NSDictionary *)Mapping;

@end
