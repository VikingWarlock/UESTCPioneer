//
//  TheoryViewController.h
//  UESTCPioneer
//
//  Created by 马君 on 14-3-27.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong) NSArray * data;

- (id)initWithArray:(NSArray *)data forTitle:(NSString *)title;

@end
