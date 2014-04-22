//
//  MyCollection.h
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableView.h"
#import "constant.h"

@interface MyCollection : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) PullRefreshTableView *refreshTableView;
@property (nonatomic,strong) UILabel *label;

@end
