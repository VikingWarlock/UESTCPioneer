//
//  CheckForSuggestion_Detail.h
//  UESTCPioneer
//
//  Created by 张众 on 4/18/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableView.h"
#import "constant.h"
@interface CheckForSuggestion_Detail : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITextView *textbody;
@property (nonatomic,strong) PullRefreshTableView *refreshTableView;
@property (assign,nonatomic) NSInteger announceid;
@end
