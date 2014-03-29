//
//  RefreshRequestViewController.m
//  UESTCPioneer
//
//  Created by Sway on 14-3-28.
//  Copyright (c) 2014年 Sway. All rights reserved.
//

#import "RefreshRequestViewController.h"
#import "PioneerNewsEntity.h"
#import "UPTitleCell.h"
#import "UPMainInfoCell.h"
#import "UPFooterCell.h"

static NSString *customTitleCellIndentifier = @"CustomTitleCellIndentifier";
static NSString *customMainCellIndentifier = @"CustomMainCellIndentifier";
static NSString *customFooterCellIndentifier = @"CustomFooterCellIndentifier";
@interface RefreshRequestViewController (){

    

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation RefreshRequestViewController

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
	// Do any additional setup after loading the view.
    [self.tableView registerClass:[UPTitleCell class] forCellReuseIdentifier:customTitleCellIndentifier];
    [self.tableView registerClass:[UPMainInfoCell class] forCellReuseIdentifier:customMainCellIndentifier];
    [self.tableView registerClass:[UPFooterCell class] forCellReuseIdentifier:customFooterCellIndentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"super tableview delegate");

    NewsEntity *entity= tableViewEntitiesArray[indexPath.section];
    if (indexPath.row == 0) {
        //6.0后用这种方式更直接，可以省掉if（cell2＝＝nil）的判断   @黄卓越 2014-3-28
        UPTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:customTitleCellIndentifier forIndexPath:indexPath];

        [cell setTitle:entity.titleBody];
        [cell setTime:entity.timeAndDate];


        return cell;
    }
    else if (indexPath.row == 1) {

        
        //6.0后用这种方式更直接，可以省掉if（cell2＝＝nil）的判断   @黄卓越 2014-3-28
        UPMainInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:customMainCellIndentifier forIndexPath:indexPath];;

        [cell2 setNewsBody:entity.newsBody];
        return cell2;
    }
    else {
        //6.0后用这种方式更直接，可以省掉if（cell2＝＝nil）的判断   @黄卓越 2014-3-28
        UPFooterCell *cell3 = [tableView dequeueReusableCellWithIdentifier:customFooterCellIndentifier forIndexPath:indexPath];;

        UIButton *btn1 = (UIButton *)[cell3.contentView viewWithTag:btn1Tag];
        UIButton *btn2 = (UIButton *)[cell3.contentView viewWithTag:btn2Tag];
        commentButton *btn3 = (commentButton *)[cell3.contentView viewWithTag:btn3Tag];
        btn1.hidden = NO;
        btn2.hidden = NO;
        
        
//        commentButton *btn3 = (commentButton *)[cell3.contentView viewWithTag:btn3Tag];
//        [btn3 setTitle:[entity.numberOfComment stringValue] forState:UIControlStateNormal];
        [cell3 setCommentId:[entity.theId integerValue]];
        [cell3 setCommentNum:[entity.numberOfComment integerValue]];
        
        
        
        [btn1 setImage:[UIImage imageNamed:@"read.png"] forState:UIControlStateNormal];
        return cell3;
    }
    
    
}

#pragma mark - refresh request


-(void)pullDownRefresh:(MJRefreshBaseView *)refreshView{
    [PublicMethod ClearEntity:entityName];
    [NetworkCenter RKRequestWithData:requestData EntityName:entityName Mapping:entityMapping SuccessBlock:^(NSArray *resultArray) {
        
        NSMutableArray *dic= [[NSMutableArray alloc]init];
        [dic addObjectsFromArray:resultArray];
        
        tableViewEntitiesArray=[[NSArray alloc]initWithArray:dic];
        
        for (PioneerNewsEntity* entity in tableViewEntitiesArray){
            NSLog(@"%@",entity.titleBody);
        }
        
//        [PublicMethod ClearEntity:entityName];
        [self.tableView reloadData];
        PullUpRefreshTimes=0;
        [refreshView endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@ 下拉请求失败",entityName);
        [refreshView endRefreshing];
    }];
}
-(void)pullUpRefresh:(MJRefreshBaseView *)refreshView{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:requestData];
    [dic setObject:[NSString stringWithFormat:@"%d",PullUpRefreshTimes+2] forKey:@"page"];
    

    
    [NetworkCenter RKRequestWithData:dic EntityName:entityName Mapping:entityMapping SuccessBlock:^(NSArray *resultArray) {
        
        for (PioneerNewsEntity* entity in tableViewEntitiesArray){
            NSLog(@"%@",entity.titleBody);
        }
        
        if ([resultArray count]==0){
            [refreshView endRefreshing];
            return ;
        }
        
        NSMutableArray *newArray = [[NSMutableArray alloc]init];
        [newArray addObjectsFromArray:tableViewEntitiesArray];
        [newArray addObjectsFromArray:resultArray];
        NSArray *result = [[NSArray alloc]initWithArray:newArray];
        
        
        tableViewEntitiesArray=result;
        
//        [PublicMethod ClearEntity:entityName];
        [self.tableView reloadData];
        
        //清除core data 因为现在还没有适合下拉刷新和适合本地缓存的api

        [refreshView endRefreshing];
        PullUpRefreshTimes++;
        
    } failure:^(NSError *error) {
        NSLog(@"%@ 上拉error:%@",entityName,error);
        [refreshView endRefreshing];
    }];
}

@end
