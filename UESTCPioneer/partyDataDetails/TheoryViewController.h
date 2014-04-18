//
//  TheoryViewController.h
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataRefreshTableViewController.h"

@interface TheoryViewController : DataRefreshTableViewController<UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic,strong) UPTableView* tableView;
@property (nonatomic,strong) NSArray * data;

- (id)initWithTitle:(NSString *)title RequestData:(NSDictionary*)RequestData EntityName:(NSString *)EntityName Mapping:(NSDictionary*)Mapping;
@end
