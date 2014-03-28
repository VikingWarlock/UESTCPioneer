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
    [self.tableView registerClass:[UPTitleCell class] forCellReuseIdentifier:@"CustomTitleCellIndentifier"];
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
        static NSString *customTitleCellIndentifier = @"CustomTitleCellIndentifier";
        UPTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:customTitleCellIndentifier forIndexPath:indexPath];
        //        if(cell == nil){
        //            cell = [[UPTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTitleCellIndentifier];
        //        }
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:titleTag];
        title.text = entity.titleBody;
        UILabel *time = (UILabel *)[cell.contentView viewWithTag:timeTag];
        time.text = [entity.timeAndDate description];

        return cell;
    }
    else if (indexPath.row == 1) {
        static NSString *customMainCellIndentifier = @"CustomMainCellIndentifier";
        UPMainInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:customMainCellIndentifier];;
        if(cell2 == nil){
            cell2 = [[UPMainInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customMainCellIndentifier];
        }
        UILabel *words = (UILabel *)[cell2.contentView viewWithTag:wordsTag];
        words.text = entity.newsBody;
        return cell2;
    }
    else {
        static NSString *customFooterCellIndentifier = @"CustomFooterCellIndentifier";
        UPFooterCell *cell3 = [tableView dequeueReusableCellWithIdentifier:customFooterCellIndentifier];;
        if(cell3 == nil){
            cell3 = [[UPFooterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customFooterCellIndentifier];
        }
        UIButton *btn1 = (UIButton *)[cell3.contentView viewWithTag:btn1Tag];
        UIButton *btn2 = (UIButton *)[cell3.contentView viewWithTag:btn2Tag];
        commentButton *btn3 = (commentButton *)[cell3.contentView viewWithTag:btn3Tag];
        btn1.hidden = NO;
        btn2.hidden = NO;
        
        
//        commentButton *btn3 = (commentButton *)[cell3.contentView viewWithTag:btn3Tag];
        [btn3 setTitle:[entity.numberOfComment stringValue] forState:UIControlStateNormal];
        
        [btn1 setImage:[UIImage imageNamed:@"read.png"] forState:UIControlStateNormal];
        return cell3;
    }
    
    
}

#pragma mark - refresh request
//{"comeCode":"school","comeFrom":"电子科技大学校党委","content":" 3月20日，电子
//    "count":0,"desc":"","id":35,"picName":"","picUrl":{},"time":"2014年03月26日 11:22","title":"新闻测试——百余家用人单位来校揽才","type":"","zipPicUrl":{}},

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
