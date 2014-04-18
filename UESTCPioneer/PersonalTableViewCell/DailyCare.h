//
//  DailyCare.h
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellForDailyCare_BodyCell.h"
#import "CellForDailyCare_TitleCell.h"
#import "commentView.h"
#import "PullRefreshTableView.h"

@interface DailyCare : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) PullRefreshTableView *refreshTableView;
@property (nonatomic,strong) UILabel *label;

@end
