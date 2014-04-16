//
//  testTableView.h
//  TableView
//
//  Created by Sway on 14-3-24.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"


@interface PullRefreshTableView : UITableView
@property (nonatomic,copy)void (^pullDownBeginRefreshBlock)(MJRefreshBaseView *refreshView);
@property (nonatomic,copy)void (^pullUpBeginRefreshBlock)(MJRefreshBaseView *refreshView);

-(void)setPullDownBeginRefreshBlock:(void (^)(MJRefreshBaseView *refreshView))pullDownBeginRefreshBlock;
-(void)setPullUpBeginRefreshBlock:(void (^)(MJRefreshBaseView *refreshView))pullUpBeginRefreshBlock;
-(void)beginRefreshing;

-(void)setPullDownBeginRefreshAction:(SEL)action;
-(void)setPullUpBeginRefreshAction:(SEL)action;

-(void)freeHeaderFooter;
@end
