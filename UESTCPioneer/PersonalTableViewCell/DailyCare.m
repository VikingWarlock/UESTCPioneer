//
//  DailyCare.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "DailyCare.h"

@interface DailyCare ()
{
    MJRefreshHeaderView *header;
    MJRefreshFooterView *footer;
    NSMutableArray *info;
    int page;
}
@end

@implementation DailyCare

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        page = 2;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setAllowsSelection:NO];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.tableView registerClass:[CellForDailyCare_TitleCell class] forCellReuseIdentifier:@"title"];
    [self.tableView registerClass:[CellForDailyCare_BodyCell class] forCellReuseIdentifier:@"body"];
    
    
    //上下拉刷新
    
    header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    header.tag = MJRefreshViewTypeHeader;
    footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    footer.tag = MJRefreshViewTypeFooter;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"日常关怀";
    
    //导航栏right按钮
    UIImageView *customView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:customView.bounds];
    [customView addSubview:button];
    [button setImage:[UIImage imageNamed:@"write.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendCare:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.rightBarButtonItem = right;
    
    [header beginRefreshing];

}

- (void)dealloc
{
    [header free];
    [footer free];
}

- (void)sendCare:(id)sender
{
    commentView *co = [[commentView alloc] init];
    [co popUpCommentViewWithCommitBlock:^(NSString *commentBody) {
        
        [NetworkCenter AFRequestWithData:[RequestData sendDailyCareRequestData:commentBody] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
            if ([dic[@"result"] isEqualToString:@"success"]){
                [Alert showAlert:@"发送关怀成功!"];
                [header beginRefreshing];
                [co closeCommentView];
            }
            else {
                [Alert showAlert:@"发送关怀失败!"];
            }
            
        } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            [Alert showAlert:@"网络请求失败!"];
            NSLog(@"发布通知failureblock");
        }];
    }];
}

#pragma 下拉刷新代理


// 开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView.tag == MJRefreshViewTypeHeader) {
        [NetworkCenter AFRequestWithData:[RequestData getDailyCareRequestData:1] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
            [info removeAllObjects];
            info = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil];
            [refreshView endRefreshing];
        } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            [Alert showAlert:@"网络请求失败!"];
            [refreshView endRefreshing];
        }];
    }
    else if (refreshView.tag == MJRefreshViewTypeFooter)
    {
        if ([info count]%10 == 0)//如果一页没填满就不刷新
        {
            [NetworkCenter AFRequestWithData:[RequestData getDailyCareRequestData:page] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
                [info addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
                [refreshView endRefreshing];
            } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                [Alert showAlert:@"网络请求失败!"];
                [refreshView endRefreshing];
            }];
        }
        [refreshView endRefreshing];
    }
    
}

// 刷新完毕就会调用
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    [self.tableView reloadData];
}

// 刷新状态变更就会调用
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    
}

#pragma tableview delegate

//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

//表的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [info count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *customTitleCellIndentifier = @"title";
        CellForDailyCare_TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:customTitleCellIndentifier forIndexPath:indexPath];
        if(cell == nil){
            cell = [[CellForDailyCare_TitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTitleCellIndentifier];
        }
        cell.title.text = [info[indexPath.section] valueForKey:@"username"];
        cell.time.text = [info[indexPath.section] valueForKey:@"time"];
        return cell;
    }
    else if (indexPath.row == 1) {
        static NSString *customMainCellIndentifier = @"body";
        CellForDailyCare_BodyCell *cell2 = [tableView dequeueReusableCellWithIdentifier:customMainCellIndentifier forIndexPath:indexPath];
        if(cell2 == nil){
            cell2 = [[CellForDailyCare_BodyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customMainCellIndentifier];
        }
        cell2.body.text = [info[indexPath.section] valueForKey:@"content"];
        return cell2;
    }
    return nil;
}

//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 55;
    }
    else if (indexPath.row == 1){
        return 110;
    }
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    // indexPath.section,根据分组进行更精确的配置
    return 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

