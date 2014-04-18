//
//  MyMessage.m
//  UESTCPioneer
//
//  Created by 张众 on 3/20/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "MyMessage.h"
#import "CellWithCustomLeftImageAndLabel.h"
#import "CellForMyMessage_PopCell.h"
@interface MyMessage ()
{
    int increment;
    BOOL isSelected;
    BOOL choseMessageCell;
    NSIndexPath *popIndex;
    NSIndexPath *clickIndex;
    
    NSMutableArray *info;
    int page;
}
@end

@implementation MyMessage

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
    popIndex = [NSIndexPath indexPathForRow:-1 inSection:0];
    
    
    //使用定制的tableview，设置上下拉刷新
    __weak MyMessage* weakSelf =self;
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
    self.navigationItem.title = @"我的消息";
    
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
    return [info count] + increment;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!choseMessageCell)
    {
        static NSString *CellIdentifier = @"setcell";
        CellWithCustomLeftImageAndLabel *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CellWithCustomLeftImageAndLabel alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if ([[info[indexPath.row] valueForKey:@"chaKan"] isEqualToString:@"1"])
        {
            cell.leftImage.image = nil;
        }
        else
        {
            cell.leftImage.image = [UIImage imageNamed:@"mm.png"];
        }
        cell.label.text = [NSString stringWithFormat:@"来自%@的消息",[info[indexPath.row] valueForKey:@"userName"]];
        return cell;
    }
    else
    {
        static NSString *PopCellIdentifier = @"setpopcell";
        CellForMyMessage_PopCell *popcell = [tableView dequeueReusableCellWithIdentifier:PopCellIdentifier];
        if (popcell == nil) {
            popcell = [[CellForMyMessage_PopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PopCellIdentifier];
        }
        popcell.label.text = @"xxx祝您生日快乐!";
        choseMessageCell = NO;
        return popcell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *indexOfInsert = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
    [self.refreshTableView beginUpdates];
    if (isSelected == NO)
    {
        [((CellWithCustomLeftImageAndLabel *)[self.refreshTableView cellForRowAtIndexPath:indexPath]).leftImage removeFromSuperview];
        increment++;
        [self.refreshTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexOfInsert] withRowAnimation:UITableViewRowAnimationTop];
        isSelected = YES;
        choseMessageCell = YES;
#warning magic number following!!!
        UIButton *mask = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        [self.view insertSubview:mask aboveSubview:self.view];
        [mask addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
        self.refreshTableView.scrollEnabled = NO;
    }
    popIndex = indexOfInsert;
    clickIndex = indexPath;
    [self.refreshTableView endUpdates];
}

- (void)popBack:(id)sender
{
    increment--;
    [self.refreshTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:popIndex] withRowAnimation:UITableViewRowAnimationTop];
    [self.refreshTableView deselectRowAtIndexPath:clickIndex animated:NO];
    isSelected = NO;
    [sender removeFromSuperview];
    self.refreshTableView.scrollEnabled = YES;
}

- (PullRefreshTableView *)refreshTableView
{
    if (!_refreshTableView) {
        _refreshTableView = [[PullRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44- 20) style:UITableViewStyleGrouped];
        [_refreshTableView registerClass:[CellWithCustomLeftImageAndLabel class] forCellReuseIdentifier:@"setcell"];
        [_refreshTableView registerClass:[CellForMyMessage_PopCell class] forCellReuseIdentifier:@"setpopcell"];
        if(IS_IOS7)
            _refreshTableView.separatorInset = UIEdgeInsetsZero;
        _refreshTableView.delegate = self;
        _refreshTableView.dataSource = self;
    }
    return _refreshTableView;
}

-(void)pullDown:(MJRefreshBaseView*)refreshView
{
    [NetworkCenter AFRequestWithData:[RequestData getListOfMessageRequestDataWithPage:1] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
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
        [NetworkCenter AFRequestWithData:[RequestData getListOfMessageRequestDataWithPage:page] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
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

