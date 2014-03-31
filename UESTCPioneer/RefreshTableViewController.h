//
//  RefreshTableViewController.h
//  UESTCPioneer
//
//  Created by Sway on 14-3-25.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPTableView.h"

@interface RefreshTableViewController : UIViewController{
    ///上拉加载的次数，仅仅是一个变量，请子类自行使用
    NSInteger PullUpRefreshTimes;
    NSArray *tableViewVerticalConstraint;
    NSLayoutConstraint *tableViewTopConstraint;
}



@property (nonatomic) UPTableView* tableView;
#pragma mark - 下拉刷新和上拉加载


///下拉刷新回调函数，供子类重载
-(void)pullDownRefresh:(MJRefreshBaseView*)refreshView;


///上啦加载回调函数，供子类重载
-(void)pullUpRefresh:(MJRefreshBaseView *)refreshView;
@end
