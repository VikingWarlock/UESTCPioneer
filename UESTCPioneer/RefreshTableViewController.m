//
//  RefreshTableViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-25.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "RefreshTableViewController.h"

@interface RefreshTableViewController(){

}

@end

@interface RefreshTableViewController ()

@end

@implementation RefreshTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PullUpRefreshTimes=0;
    [self _loadUPTableView];
    
    __weak RefreshTableViewController *weakSelf = self;
    [self.tableView setPullDownBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullDownRefresh:refreshView];
    }];
    
    [self.tableView setPullUpBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullUpRefresh:refreshView];
    }];
    
    [self.tableView beginRefreshing];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)_loadUPTableView{
    //@加UPTableView
    self.tableView=[[UPTableView alloc]initWithFrame:CGRectMake(10, 0, 300, 455) style:UITableViewStyleGrouped];
    if(IS_IOS7)
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setAllowsSelection:NO];
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 455)];
    [background setBackgroundColor:self.tableView.backgroundColor];
    [self.view addSubview:background];
    [self.view addSubview:self.tableView];
}

#pragma mark - 下拉刷新和上拉加载
-(void)pullDownRefresh:(MJRefreshBaseView*)refreshView{}

-(void)pullUpRefresh:(MJRefreshBaseView *)refreshView{}

@end
