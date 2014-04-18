//
//  BirthCare.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "BirthCare.h"
#import "CellForBirthCare.h"
@interface BirthCare ()
{
    NSMutableArray *info;
    int page;
}

@end

@implementation BirthCare

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
    __weak BirthCare* weakSelf =self;
    [self.refreshTableView setPullDownBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullDown:refreshView];
    }];
    [self.refreshTableView setPullUpBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullUp:refreshView];
    }];
    
    info = [[NSMutableArray alloc] init];
    page = 2;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"生日关怀";
    
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

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [info count];//[BirthListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"setcell";
    CellForBirthCare *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CellForBirthCare alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.name.text = [info[indexPath.row] valueForKey:@"username"];
    cell.date.text = [NSString stringWithFormat:@"%@天后过生日",[info[indexPath.row] valueForKey:@"date"]];
    cell.button.tag = [[info[indexPath.row] valueForKey:@"userid"] intValue];
    [cell.button addTarget:self action:@selector(sendWish:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma 网络请求部分

- (void)sendWish:(id)sender
{
    [NetworkCenter AFRequestWithData:[RequestData sendBirthCareRequestDataWithForuserid:((UIButton *)sender).tag] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"result"] isEqualToString:@"success"]){
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(250,17, 60, 30)];
            label.text = @"已送祝福";
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
            [((UIButton *)sender).superview addSubview:label];
            [((UIButton *)sender) setFrame:CGRectMake(230, 25, 15, 15)];
            [((UIButton *)sender) setBackgroundImage:[UIImage imageNamed:@"already.png"] forState:UIControlStateNormal];
        }
        else if ([dic[@"cause"] isEqualToString:@"已经送过祝福了"]){
            [Alert showAlert:@"送过祝福啦"];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(250,17, 60, 30)];
            label.text = @"已送祝福";
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithRed:119.0/255.0 green:123.0/255.0 blue:134.0/255.0 alpha:1];
            [((UIButton *)sender).superview addSubview:label];
            [((UIButton *)sender) setFrame:CGRectMake(230, 25, 15, 15)];
            [((UIButton *)sender) setBackgroundImage:[UIImage imageNamed:@"already.png"] forState:UIControlStateNormal];
        }
        else
        {
            [Alert showAlert:@"送祝福失败"];
        }
        
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Alert showAlert:@"网络请求错误!"];
        NSLog(@"送祝福失败");
    }];
}

- (PullRefreshTableView *)refreshTableView
{
    if (!_refreshTableView) {
        _refreshTableView = [[PullRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44- 20) style:UITableViewStyleGrouped];
        _refreshTableView.delegate = self;
        _refreshTableView.dataSource = self;
        if(IS_IOS7)
            _refreshTableView.separatorInset = UIEdgeInsetsZero;
        [_refreshTableView setAllowsSelection:NO];
        [_refreshTableView registerClass:[CellForBirthCare class] forCellReuseIdentifier:@"setcell"];
    }
    return _refreshTableView;
}

-(void)pullDown:(MJRefreshBaseView*)refreshView
{
    [NetworkCenter AFRequestWithData:[RequestData getListOfBirthRequestDataWithPage:1] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        [info removeAllObjects];
        [info addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
        [refreshView endRefreshing];
        [self.refreshTableView reloadData];
        if ([info count] == 0) {
            self.label.text = @"您暂时没有好友将要过生日!";
        }
        else
        {
            self.label = nil;
        }
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
        [NetworkCenter AFRequestWithData:[RequestData getListOfBirthRequestDataWithPage:page] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
            [info addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
            [refreshView endRefreshing];
            [self.refreshTableView reloadData];
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
