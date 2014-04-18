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
    NSMutableArray *info;
    int page;
}
@end

@implementation DailyCare

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        page = 2;
        [self.view addSubview:self.refreshTableView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    info = [[NSMutableArray alloc] init];
    
    //使用定制的tableview，设置上下拉刷新
    __weak DailyCare* weakSelf =self;
    [self.refreshTableView setPullDownBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullDown:refreshView];
    }];
    [self.refreshTableView setPullUpBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullUp:refreshView];
    }];
    
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
    
    [self.refreshTableView beginRefreshing];
}

-(void)dealloc{
    [self.refreshTableView freeHeaderFooter];
}

- (void)sendCare:(id)sender
{
    commentView *co = [[commentView alloc] init];
    [co popUpCommentViewWithCommitBlock:^(NSString *commentBody) {
        
        [NetworkCenter AFRequestWithData:[RequestData sendDailyCareRequestDataWithContent:commentBody] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
            if ([dic[@"result"] isEqualToString:@"success"]){
                [Alert showAlert:@"发送关怀成功!"];
                [self.refreshTableView beginRefreshing];
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

- (PullRefreshTableView *)refreshTableView
{
    if (!_refreshTableView) {
        _refreshTableView = [[PullRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44- 20) style:UITableViewStyleGrouped];
        _refreshTableView.delegate = self;
        _refreshTableView.dataSource = self;
        [_refreshTableView setAllowsSelection:NO];
        _refreshTableView.separatorInset = UIEdgeInsetsZero;
        [_refreshTableView registerClass:[CellForDailyCare_TitleCell class] forCellReuseIdentifier:@"title"];
        [_refreshTableView registerClass:[CellForDailyCare_BodyCell class] forCellReuseIdentifier:@"body"];
    }
    return _refreshTableView;
}

-(void)pullDown:(MJRefreshBaseView*)refreshView
{
    [NetworkCenter AFRequestWithData:[RequestData getDailyCareRequestDataWithPage:1] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        [info removeAllObjects];
        [info addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
        [refreshView endRefreshing];
        [self.refreshTableView reloadData];
        page = 2;
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Alert showAlert:@"网络请求失败!"];
        [refreshView endRefreshing];
    }];
}

-(void)pullUp:(MJRefreshBaseView*)refreshView
{
    if ([info count]%10 == 0)//如果一页没填满就不刷新
    {
        [NetworkCenter AFRequestWithData:[RequestData getDailyCareRequestDataWithPage:page] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
            [info addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
            [refreshView endRefreshing];
            [self.refreshTableView reloadData];
            if ([info count] == 0) {
                self.label.text = @"您暂时没有任何消息!";
            }
            else
            {
                self.label = nil;
            }
            page++;
        } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            [Alert showAlert:@"网络请求失败!"];
            [refreshView endRefreshing];
        }];
    }
    else
        [refreshView endRefreshing];
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        _label.center = self.refreshTableView.center;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor grayColor];
        [self.refreshTableView addSubview:_label];
    }
    return _label;
}

@end

