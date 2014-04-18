//
//  MyCollection.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "MyCollection.h"
#import "constant.h"
#import "CellWithCustomLeftImageAndLabel.h"
#import "CellWithCustomLeftImageAndLabel.h"

@interface MyCollection ()
{
    NSMutableArray *info;
    NSMutableArray *content;
    int page;
}

@end

@implementation MyCollection

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
    __weak MyCollection* weakSelf =self;
    [self.refreshTableView setPullDownBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullDown:refreshView];
    }];
    [self.refreshTableView setPullUpBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullUp:refreshView];
    }];
    
    info = [[NSMutableArray alloc] init];
    content = [[NSMutableArray alloc] init];

    page = 2;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"我的收藏";
    
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
    cell.leftImage.image = [UIImage imageNamed:@"col.png"];
    cell.label.text = [info[indexPath.row] valueForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    UITextView *textview = [[UITextView alloc] initWithFrame:vc.view.frame];
    
    [NetworkCenter AFRequestWithData:[RequestData getPerAdminNoticeRequestDataWithNoticeid:[[info[indexPath.row] valueForKey:@"id"] intValue]]  SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        [content addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
        if ([content count] > 0) {
            textview.text = [content[0] valueForKey:@"content"];
        }
        else
        {
            textview.text = @"数据请求错误!";
        }
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Alert showAlert:@"网络请求失败!"];
    }];
    
    [vc.view addSubview:textview];
    NSLog(@"%@",textview.text);
    [self.leveyTabBarController.navigationController pushViewController:vc animated:YES];
    [self.refreshTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (PullRefreshTableView *)refreshTableView
{
    if (!_refreshTableView) {
        _refreshTableView = [[PullRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44- 20) style:UITableViewStyleGrouped];
        [_refreshTableView registerClass:[CellWithCustomLeftImageAndLabel class] forCellReuseIdentifier:@"setcell"];
        if(IS_IOS7)
            _refreshTableView.separatorInset = UIEdgeInsetsZero;
        _refreshTableView.delegate = self;
        _refreshTableView.dataSource = self;
    }
    return _refreshTableView;
}

-(void)pullDown:(MJRefreshBaseView*)refreshView
{
    [NetworkCenter AFRequestWithData:[RequestData getCollectionRequestDataWithPage:1] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
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
        [NetworkCenter AFRequestWithData:[RequestData getCollectionRequestDataWithPage:page] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
            [info addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
            [refreshView endRefreshing];
            [self.refreshTableView reloadData];
            if ([info count] == 0) {
                self.label.text = @"您暂时没有任何收藏!";
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
