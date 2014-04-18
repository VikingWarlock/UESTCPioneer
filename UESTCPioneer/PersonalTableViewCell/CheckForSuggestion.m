//
//  CheckForSuggestion.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CheckForSuggestion.h"
#import "CellWithCustomLeftImageAndLabel.h"
#import "CheckForSuggestion_Detail.h"

@interface CheckForSuggestion ()
{
    NSMutableArray *info;
    int page;
}
@end

@implementation CheckForSuggestion

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view addSubview:self.refreshTableView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //使用定制的tableview，设置上下拉刷新
    __weak CheckForSuggestion* weakSelf =self;
    [self.refreshTableView setPullDownBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullDown:refreshView];
    }];
    [self.refreshTableView setPullUpBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullUp:refreshView];
    }];
    
    info = [[NSMutableArray alloc] init];
    page = 2;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"查看意见";
    
    [self.refreshTableView beginRefreshing];

}

-(void)dealloc{
    [self.refreshTableView freeHeaderFooter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [info count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"setcell";
    CellWithCustomLeftImageAndLabel *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CellWithCustomLeftImageAndLabel alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.leftImage.image = [UIImage imageNamed:@"vw.png"];
    cell.label.text =  [info[indexPath.row] valueForKeyPath:@"theme"];
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckForSuggestion_Detail *aview = [[CheckForSuggestion_Detail alloc] init];
    aview.announceid = [[info[indexPath.row] valueForKey:@"id"] intValue];
    [self.leveyTabBarController.navigationController pushViewController:aview animated:YES];
    [self.refreshTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (PullRefreshTableView *)refreshTableView
{
    if (!_refreshTableView) {
        _refreshTableView = [[PullRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44- 20) style:UITableViewStyleGrouped];
        if(IS_IOS7)
            _refreshTableView.separatorInset = UIEdgeInsetsZero;
        [_refreshTableView registerClass:[CellWithCustomLeftImageAndLabel class] forCellReuseIdentifier:@"setcell"];
        
        _refreshTableView.delegate = self;
        _refreshTableView.dataSource = self;
    }
    return _refreshTableView;
}

-(void)pullDown:(MJRefreshBaseView*)refreshView
{
    [NetworkCenter AFRequestWithData:[RequestData getListOfAnnounceRequestDataWithPage:1] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
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
    {   //请求消息列表
        [NetworkCenter AFRequestWithData:[RequestData getListOfAnnounceRequestDataWithPage:page] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
            [info addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
            [refreshView endRefreshing];
            [self.refreshTableView reloadData];
            if ([info count] == 0) {
                self.label.text = @"您暂时没有任何意见!";
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

