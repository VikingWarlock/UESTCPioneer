//
//  CheckForSuggestion_Detail.m
//  UESTCPioneer
//
//  Created by 张众 on 4/18/14.
//  Copyright (c) 2014 Sway. All rights reserved.
//

#import "CheckForSuggestion_Detail.h"
#import "CellForSuggestion_Detail.h"
@interface CheckForSuggestion_Detail ()
{
    NSMutableArray *content;
    NSMutableArray *suggestion;
    int page;
}

@end

@implementation CheckForSuggestion_Detail

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
    __weak CheckForSuggestion_Detail* weakSelf =self;
    [self.refreshTableView setPullDownBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullDown:refreshView];
    }];
    [self.refreshTableView setPullUpBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullUp:refreshView];
    }];
    
    content = [[NSMutableArray alloc] init];
    suggestion = [[NSMutableArray alloc] init];
    page = 2;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.refreshTableView beginRefreshing];
}

-(void)dealloc{
    [self.refreshTableView freeHeaderFooter];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark tableview stuff
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [suggestion count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 350;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.textbody;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"suggestion";
    CellForSuggestion_Detail *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CellForSuggestion_Detail alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.date.text = [suggestion[indexPath.row] valueForKey:@"commentDate"];
    cell.name.text = [suggestion[indexPath.row] valueForKey:@"commentAuthor"];
    cell.content.text = [suggestion[indexPath.row] valueForKey:@"commentContent"];
    return cell;
}

#pragma mark 网络请求

- (PullRefreshTableView *)refreshTableView
{
    if (!_refreshTableView) {
        _refreshTableView = [[PullRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44- 20) style:UITableViewStyleGrouped];
        self.refreshTableView.delegate = self;
        self.refreshTableView.dataSource = self;
        [self.refreshTableView registerClass:[CellForSuggestion_Detail class] forCellReuseIdentifier:@"suggestion"];
        if(IS_IOS7)
            _refreshTableView.separatorInset = UIEdgeInsetsZero;
    }
    return _refreshTableView;
}

-(void)pullDown:(MJRefreshBaseView*)refreshView
{
    //请求内容
    [NetworkCenter AFRequestWithData:[RequestData getAnnounceContentRequestDataWithAnnounceid:self.announceid] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        [content removeAllObjects];
        [content addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
        if ([content count] > 0) {
            self.textbody.text = [content[0] valueForKey:@"content"];
        }
        else
        {
            self.textbody.text = @"请求数据错误!";
        }
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Alert showAlert:@"内容请求失败!"];
    }];

    
    //请求评论
    [NetworkCenter AFRequestWithData:[RequestData getAnnnounceProposalRequestDataWithAnnounceid:self.announceid page:1] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
        [suggestion removeAllObjects];
        [suggestion addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
        [refreshView endRefreshing];
        [self.refreshTableView reloadData];
        page = 2;
    } FailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Alert showAlert:@"评论请求失败!"];
        [refreshView endRefreshing];
    }];
}

-(void)pullUp:(MJRefreshBaseView*)refreshView
{
    if ([content count]%10 == 0)//如果一页没填满就不刷新
    {
        [NetworkCenter AFRequestWithData:[RequestData getAnnnounceProposalRequestDataWithAnnounceid:self.announceid page:page] SuccessBlock:^(AFHTTPRequestOperation *operation, id resultObject) {
            [suggestion addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:resultObject options:NSJSONReadingMutableContainers error:nil]];
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


#pragma mark lazy initialization

- (UITextView *)textbody
{
    if (!_textbody) {
        _textbody = [[UITextView alloc] init];
        
        
//        CGSize textSize = [_textbody.text boundingRectWithSize:_textbody.bounds.size
//                                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                                    attributes:@{NSFontAttributeName: _textbody.font}
//                                                       context:nil].size;
//        
        _textbody.frame = CGRectMake(10, 0, 300, 0.1);
        _textbody.backgroundColor = [UIColor whiteColor];
        _textbody.text = @"texttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttext";
        _textbody.font = [UIFont systemFontOfSize:17];
        _textbody.editable = NO;
    }
    return _textbody;
}


@end
