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
#define RowHeight     44
#define RowSubHeight  30
@interface MyMessage ()
{
    BOOL isOpen;
    NSIndexPath *lastClickIndex;
    BOOL isClickSameCell;
    NSMutableArray *array;
    
    NSMutableArray *info;
    NSMutableArray *message;
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
    [_refreshTableView registerClass:[CellForMyMessage_PopCell class] forCellReuseIdentifier:@"reusecell"];
    array = [[NSMutableArray alloc] init];
    isOpen = YES;
    isClickSameCell = NO;
    lastClickIndex = [[NSIndexPath alloc] init];
    lastClickIndex = nil;
    
    
    
    
    //使用定制的tableview，设置上下拉刷新
    __weak MyMessage* weakSelf =self;
    [self.refreshTableView setPullDownBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullDown:refreshView];
    }];
    [self.refreshTableView setPullUpBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullUp:refreshView];
    }];
    
    info = [[NSMutableArray alloc] init];
    message = [[NSMutableArray alloc] init];
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
    
    
    self.leveyTabBarController.navigationItem.title = @"";
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [info count];;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:lastClickIndex]) {
        if (isOpen == YES) {
            
            return RowHeight + RowSubHeight;
            
        }else{
            
            return RowHeight;
        }
        
    }
    else
        return RowHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuserId = @"reusecell";
    CellForMyMessage_PopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuserId];
    cell.leftImage.image = [UIImage imageNamed:@"mm.png"];//cell重用的时候重置image
    if (cell == nil) {
        cell = [[CellForMyMessage_PopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuserId];
        if ([info[indexPath.row] valueForKeyPath:@"chaKan"])
            cell.leftImage.image = nil;
        else
            cell.leftImage.image = [UIImage imageNamed:@"mm.png"];
    }
    
    if (indexPath.row == lastClickIndex.row && lastClickIndex != nil) {
        //如果是展开
        if (isOpen == YES) {
            cell.isOpen = YES;

        }else{
            //收起
            cell.isOpen = NO;
            cell.content.text = nil;
        }
        
        //不是自身
    } else {
        cell.isOpen = NO;
        cell.content.text = nil;
    }
    cell.title.text = [NSString stringWithFormat:@"来自%@的消息",[info[indexPath.row] valueForKeyPath:@"userName"] ];
    
    for (NSIndexPath *obj in array) {
        if ([obj isEqual:indexPath]) {
            cell.leftImage.image = nil;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [NetworkCenter AFRequestWithData:[RequestData getSpecialMessageRequestDataWithMsgid:[[info[indexPath.row] valueForKey:@"id"] intValue]] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
//        [message removeAllObjects];
//        [message addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
//        
//    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [Alert showAlert:@"网络请求失败!"];
//    }];
//    
//    
//    
//    
//    NSIndexPath *indexOfInsert = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
//    [self.refreshTableView beginUpdates];
//    if (isSelected == NO)
//    {
//        [((CellWithCustomLeftImageAndLabel *)[self.refreshTableView cellForRowAtIndexPath:indexPath]).leftImage removeFromSuperview];
//        increment++;
//        [self.refreshTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexOfInsert] withRowAnimation:UITableViewRowAnimationTop];
//        isSelected = YES;
//        choseMessageCell = YES;
//#warning magic number following!!!
//        UIButton *mask = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
//        [self.view insertSubview:mask aboveSubview:self.view];
//        [mask addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
//        self.refreshTableView.scrollEnabled = NO;
//    }
//    popIndex = indexOfInsert;
//    clickIndex = indexPath;
//    [self.refreshTableView endUpdates];
    

    [NetworkCenter AFRequestWithData:[RequestData getSpecialMessageRequestDataWithMsgid:[[info[indexPath.row] valueForKey:@"id"] intValue]] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        [message removeAllObjects];
        [message addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
        ((CellForMyMessage_PopCell *)[tableView cellForRowAtIndexPath:indexPath]).content.text = [message[0] valueForKey:@"content"];

    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Alert showAlert:@"网络请求失败!"];
    }];
    
    
    
    //将索引加到数组中
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    //判断选中不同row状态时候
    if (lastClickIndex != nil && indexPath.row == lastClickIndex.row) {
        //将选中的和所有索引都加进数组中
        //        indexPaths = [NSArray arrayWithObjects:indexPath,selectedIndex, nil];
        isOpen = !isOpen;
    }else if (lastClickIndex != nil && indexPath.row != lastClickIndex.row) {
        indexPaths = [NSArray arrayWithObjects:indexPath,lastClickIndex, nil];
        isOpen = YES;
    }
    //记下选中的索引
    lastClickIndex = indexPath;
    //刷新
    ((CellForMyMessage_PopCell *)[tableView cellForRowAtIndexPath:indexPath]).leftImage.image = nil;
    [array addObject:indexPath];
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}


- (PullRefreshTableView *)refreshTableView
{
    if (!_refreshTableView) {
        _refreshTableView = [[PullRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44- 20) style:UITableViewStyleGrouped];
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

